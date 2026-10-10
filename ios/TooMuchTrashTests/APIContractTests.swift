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

    private func api(_ transport: ScriptedTransport, privateURL: String = "https://private.example.test:8443") throws -> LiveCollectorAPI {
        LiveCollectorAPI(configuration: try APIConfiguration(publicURL: "https://public.example.test",
                                                             privateAdminURL: privateURL), transport: transport)
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
}
