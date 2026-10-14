import XCTest
@testable import TooMuchTrash

@MainActor
private final class ScriptedTransport: HTTPTransport {
    struct Reply { let status: Int; let json: String; var type = "application/json"; var url: URL?; var retryAfter: String? }
    var replies: [Reply] = []
    var requests: [URLRequest] = []
    var stagedUpload: Data?
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        requests.append(request)
        let reply = replies.removeFirst()
        var headers = ["Content-Type": reply.type]
        if let retryAfter = reply.retryAfter { headers["Retry-After"] = retryAfter }
        let response = HTTPURLResponse(url: reply.url ?? request.url!, statusCode: reply.status,
                                       httpVersion: nil, headerFields: headers)!
        return (Data(reply.json.utf8), response)
    }
    func upload(for request: URLRequest, from file: URL) async throws -> (Data, HTTPURLResponse) {
        stagedUpload = try Data(contentsOf: file)
        return try await data(for: request)
    }
}

@MainActor
final class APIContractTests: XCTestCase {
    func testHTTPSOriginPolicy() throws {
        let rejected = ["http://localhost", "https://user:password@example.test", "https://example.test/api",
                        "https://example.test?token=secret", "https://example.test#token", "file:///tmp/a"]
        for address in rejected { XCTAssertThrowsError(try APIConfiguration(publicURL: address)) }
        XCTAssertThrowsError(try APIConfiguration(publicURL: "https://node.example.test/",
                                                  privateAdminURL: "https://node.example.test:443"))
        let configuration = try APIConfiguration(publicURL: "https://NODE.example.test:10000/",
                                                  privateAdminURL: "https://node.example.test:8443")
        XCTAssertEqual(configuration.endpoint("api/v1/auth/me").absoluteString,
                       "https://node.example.test:10000/api/v1/auth/me")
    }

    func testProductionWebsiteOriginAlsoServesCollectorOnStandardHTTPS() throws {
        let origin = "https://too-much-trash.mongoose-bonito.ts.net"
        let configuration = try APIConfiguration(publicURL: origin + ":443/",
            privateAdminURL: origin + ":8443")
        XCTAssertEqual(configuration.publicOrigin.absoluteString, origin)
        XCTAssertEqual(configuration.endpoint("api/v1/auth/enroll").absoluteString,
            origin + "/api/v1/auth/enroll")
        XCTAssertEqual(configuration.privateAdminOrigin?.absoluteString, origin + ":8443")
        XCTAssertFalse(configuration.simulatorLocal)
        XCTAssertThrowsError(try APIConfiguration(publicURL: origin,
            privateAdminURL: origin + ":443/"))
    }

    private func api(_ transport: ScriptedTransport, privateURL: String = "https://private.example.test:8443") throws -> LiveCollectorAPI {
        LiveCollectorAPI(configuration: try APIConfiguration(publicURL: "https://public.example.test",
                                                             privateAdminURL: privateURL), transport: transport)
    }

    func testSimulatorLocalModeIsExplicitAndLocalhostOnly() throws {
        XCTAssertThrowsError(try APIConfiguration(publicURL: "http://localhost:8082"))
        #if DEBUG && targetEnvironment(simulator)
        XCTAssertTrue(APIConfiguration.supportsSimulatorLocal)
        let local = try APIConfiguration(publicURL: "http://LOCALHOST:8082/",
                                         privateAdminURL: "http://localhost:8081", simulatorLocal: true)
        XCTAssertEqual(local.publicOrigin.absoluteString, "http://localhost:8082")
        XCTAssertTrue(local.simulatorLocal)
        let mixed = try APIConfiguration(publicURL: "http://localhost:8082",
            privateAdminURL: APIConfiguration.developmentAdminURL, simulatorLocal: true)
        XCTAssertEqual(mixed.privateAdminOrigin?.scheme, "https")
        XCTAssertEqual(APIConfiguration.localCollector?.publicOrigin.absoluteString, "http://localhost:8082")
        XCTAssertEqual(APIConfiguration.developmentNetwork.publicOrigin.scheme, "https")
        for origin in ["http://192.168.1.2:8082", "http://example.test", "http://localhost.example.test",
                       "http://user:secret@localhost:8082", "http://localhost:8082/api",
                       "http://localhost:8082?secret=x", "https://localhost:8082"] {
            XCTAssertThrowsError(try APIConfiguration(publicURL: origin, simulatorLocal: true))
        }
        XCTAssertThrowsError(try APIConfiguration(publicURL: "http://localhost:8082",
                                                  privateAdminURL: "http://example.test", simulatorLocal: true))
        #else
        XCTAssertFalse(APIConfiguration.supportsSimulatorLocal)
        XCTAssertThrowsError(try APIConfiguration(publicURL: "http://localhost:8082", simulatorLocal: true))
        #endif
    }

    func testSimulatorATSExceptionIsNarrowlyScoped() throws {
        let ats = Bundle.main.object(forInfoDictionaryKey: "NSAppTransportSecurity") as? [String: Any]
        #if DEBUG && targetEnvironment(simulator)
        XCTAssertEqual(ats?["NSAllowsLocalNetworking"] as? Bool, true)
        let domains = try XCTUnwrap(ats?["NSExceptionDomains"] as? [String: Any])
        XCTAssertEqual(Set(domains.keys), ["localhost"])
        XCTAssertNil(ats?["NSAllowsArbitraryLoads"])
        #else
        XCTAssertNil(ats)
        #endif
    }

    func testAdminRequiresExactIdentityAndJSONAndDoesNotUsePublicHealth() async throws {
        let transport = ScriptedTransport()
        transport.replies = [
            .init(status: 200, json: "{\"service\":\"too-much-trash-admin\",\"version\":1}"),
            .init(status: 200, json: "{\"service\":\"other-service\",\"version\":1}"),
            .init(status: 200, json: "{\"service\":\"too-much-trash-admin\",\"version\":2}"),
            .init(status: 200, json: "{\"service\":\"too-much-trash-admin\",\"version\":1}", type: "text/html"),
            .init(status: 302, json: ""),
            .init(status: 200, json: "{\"service\":\"too-much-trash-admin\",\"version\":1}", url: URL(string: "https://portal.example.test"))
        ]
        let client = try api(transport)
        let matched = await client.adminReachable()
        XCTAssertTrue(matched)
        for _ in 0..<5 {
            let visible = await client.adminReachable()
            XCTAssertFalse(visible)
        }
        for request in transport.requests {
            XCTAssertEqual(request.url?.absoluteString, "https://private.example.test:8443/api/v1/admin/reachability")
            XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
        }
    }

    func testNoPrivateOriginMeansNoAdminRequest() async throws {
        let transport = ScriptedTransport(), client = try api(transport, privateURL: "")
        let visible = await client.adminReachable()
        XCTAssertFalse(visible)
        XCTAssertTrue(transport.requests.isEmpty)
    }

    func testStructuredErrorsAndValidationArrayAreHandled() async throws {
        let transport = ScriptedTransport()
        transport.replies = [
            .init(status: 401, json: "{\"detail\":{\"code\":\"access_revoked\",\"message\":\"Revoked\"}}"),
            .init(status: 422, json: "{\"detail\":[{\"loc\":[\"body\"],\"msg\":\"Invalid\"}]}"),
            .init(status: 503, json: "")
        ]
        let client = try api(transport)
        do { _ = try await client.me(token: "test-access"); XCTFail("Expected revoked") }
        catch { XCTAssertEqual(error as? ClientError, .unauthorized("access_revoked")) }
        do { _ = try await client.enroll(invite: "test-invite", name: nil); XCTFail("Expected validation") }
        catch { XCTAssertEqual(error as? ClientError, .validation) }
        do { _ = try await client.me(token: "test-access"); XCTFail("Expected server failure") }
        catch { XCTAssertEqual(error as? ClientError, .server) }
    }

    func testEnrollmentContractAndSecretPlacement() async throws {
        let transport = ScriptedTransport()
        transport.replies = [.init(status: 201, json: "{\"installation_id\":\"00000000-0000-0000-0000-000000000001\",\"access_token\":\"test-access\",\"refresh_token\":\"test-refresh\",\"token_type\":\"Bearer\",\"expires_in\":900,\"refresh_expires_in\":2592000}")]
        let response = try await api(transport).enroll(invite: "test-invite", name: "Test iPhone")
        XCTAssertEqual(response.expiresIn, 900)
        let request = try XCTUnwrap(transport.requests.first)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.path, "/api/v1/auth/enroll")
        XCTAssertFalse(request.url!.absoluteString.contains("test-invite"))
        let body = try JSONDecoder().decode([String: String].self, from: XCTUnwrap(request.httpBody))
        XCTAssertEqual(body["invite_code"], "test-invite")
        XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
    }

    func testRetryAfterIsDecodedWithoutRetryingRequest() async throws {
        let transport = ScriptedTransport()
        transport.replies = [.init(status: 429, json: "{\"detail\":{\"code\":\"rate_limited\"}}", retryAfter: "60")]
        do { _ = try await api(transport).enroll(invite: "test-invite", name: nil); XCTFail("Expected throttling") }
        catch { XCTAssertEqual(error as? ClientError, .rateLimited(60)) }
        XCTAssertEqual(transport.requests.count, 1)
    }

    func testUnexpectedResponseOriginCannotAuthorize() async throws {
        let transport = ScriptedTransport()
        transport.replies = [.init(status: 200, json: "{}", url: URL(string: "https://other.example.test/api/v1/auth/me"))]
        do { _ = try await api(transport).me(token: "test-access"); XCTFail("Expected origin rejection") }
        catch { XCTAssertEqual(error as? ClientError, .invalidResponse) }
    }

    func testMultipartUploadUsesBearerAndMOVContentType() async throws {
        let transport = ScriptedTransport()
        transport.replies = [.init(status: 202, json: "{\"id\":\"00000000-0000-0000-0000-000000000002\",\"status\":\"queued\",\"filename\":\"pickup.mov\",\"size_bytes\":10}")]
        let file = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mov")
        try Data("test-video".utf8).write(to: file)
        defer { try? FileManager.default.removeItem(at: file) }
        let receipt = try await api(transport).upload(file: file, token: "test-access")
        XCTAssertEqual(receipt.status, "queued")
        XCTAssertEqual(transport.requests[0].value(forHTTPHeaderField: "Authorization"), "Bearer test-access")
        let body = String(decoding: try XCTUnwrap(transport.stagedUpload), as: UTF8.self)
        XCTAssertTrue(body.contains("name=\"file\""))
        XCTAssertTrue(body.contains("Content-Type: video/quicktime"))
        XCTAssertTrue(body.contains("test-video"))
        XCTAssertFalse(body.contains("test-access"))
    }

    func testKeyedUploadsReuseStableBodyAndHeaderAndDecodeEcho() async throws {
        let transport = ScriptedTransport(), id = UUID()
        let json = "{\"id\":\"00000000-0000-0000-0000-000000000002\",\"status\":\"queued\",\"filename\":\"pickup.mov\",\"size_bytes\":5,\"client_capture_id\":\"\(id.uuidString)\"}"
        transport.replies = [.init(status: 202, json: json), .init(status: 202, json: json)]
        let file = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID()).mov")
        try Data("video".utf8).write(to: file)
        defer { try? FileManager.default.removeItem(at: file) }
        let client = try api(transport)
        let first = try await client.upload(file: file, captureID: id, token: "test-access", progress: { _, _ in })
        let body = transport.stagedUpload
        let repeated = try await client.upload(file: file, captureID: id, token: "test-access", progress: { _, _ in })
        XCTAssertEqual(first.clientCaptureID, id)
        XCTAssertEqual(first.id, repeated.id)
        XCTAssertEqual(body, transport.stagedUpload)
        XCTAssertTrue(transport.requests.allSatisfy { $0.value(forHTTPHeaderField: "Idempotency-Key") == id.uuidString })
    }

    func testEndSessionUsesRefreshProofNotAdminOrBearerAndChecksJSON() async throws {
        let transport = ScriptedTransport(), id = UUID()
        transport.replies = [.init(status: 200, json: "{\"installation_id\":\"\(id)\",\"revoked\":true}")]
        let result = try await api(transport).endSession(refreshToken: "test-refresh")
        XCTAssertEqual(result.installationID, id)
        XCTAssertTrue(result.revoked)
        let request = try XCTUnwrap(transport.requests.first)
        XCTAssertEqual(request.url?.path, "/api/v1/auth/end-session")
        XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
        XCTAssertNil(request.value(forHTTPHeaderField: "X-TMT-Admin"))
        let body = try JSONDecoder().decode([String: String].self, from: XCTUnwrap(request.httpBody))
        XCTAssertEqual(body, ["refresh_token": "test-refresh"])
        XCTAssertFalse(request.url!.absoluteString.contains("test-refresh"))
    }

    func testLookupAndConflictContracts() async throws {
        let transport = ScriptedTransport(), id = UUID()
        transport.replies = [.init(status: 200, json: "{\"id\":\"\(UUID())\",\"status\":\"failed\",\"filename\":\"pickup.mov\",\"size_bytes\":5,\"client_capture_id\":\"\(id)\"}"),
                             .init(status: 409, json: "{\"detail\":{\"code\":\"idempotency_conflict\"}}")]
        let client = try api(transport)
        let receipt = try await client.uploaded(captureID: id, token: "test-access")
        XCTAssertEqual(receipt.clientCaptureID, id)
        XCTAssertEqual(transport.requests[0].url?.path, "/api/v1/media/by-client/\(id.uuidString)")
        do { _ = try await client.uploaded(captureID: id, token: "test-access"); XCTFail("Expected conflict") }
        catch { XCTAssertEqual(error as? ClientError, .idempotencyConflict) }
    }

    func testOlderBackendCapabilityIsNotAssumed() throws {
        let json = "{\"installation_id\":\"\(UUID())\",\"quota_bytes\":1,\"quota_uploads\":1,\"used_bytes\":0,\"used_uploads\":0}"
        XCTAssertNil(try JSONDecoder().decode(Installation.self, from: Data(json.utf8)).mediaContractVersion)
    }
}
