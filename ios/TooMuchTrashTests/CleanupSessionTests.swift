import XCTest
import CoreLocation
@testable import TooMuchTrash

@MainActor final class CleanupSessionTests: XCTestCase {
    func testCameraPreferencesPersistAndRejectUnknownModels() throws {
        let key = UUID().uuidString, defaults = try XCTUnwrap(UserDefaults(suiteName: key))
        defer { defaults.removePersistentDomain(forName: key) }
        let settings = CameraViewSettings(defaults: defaults)
        settings.update { $0.modelEnabled = false; $0.fullRecordingButtonEnabled = false }
        let restored = CameraViewSettings(defaults: defaults)
        XCTAssertFalse(restored.configuration.runsModel)
        XCTAssertFalse(restored.configuration.fullRecordingButtonEnabled)
        restored.update { $0.modelEnabled = true; $0.selectedModelID = "unknown" }
        XCTAssertFalse(restored.configuration.runsModel)
    }
    func testSessionSurvivesRelaunchAndWatchRetriesDoNotRestartIt() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let store = CleanupSessionStore(), id = UUID()
        try store.bind(directory: directory); try store.start(id: id, at: 100)
        try store.edit(id: id, name: "Beach cleanup", description: "Along the shoreline")
        let revision = try XCTUnwrap(store.current).revision
        try store.acknowledge(id: id, revision: revision - 1)
        XCTAssertTrue(try XCTUnwrap(store.current).needsSync)
        try store.stop(id: id, at: 120)
        try store.start(id: id, at: 100) // retry after stop cannot restart it
        XCTAssertNil(store.activeID)
        let restored = CleanupSessionStore(); try restored.bind(directory: directory)
        XCTAssertEqual(restored.current?.name, "Beach cleanup")
        XCTAssertEqual(restored.current?.ended_at, 120)
        XCTAssertEqual(restored.records.count, 1)
    }
    func testLocationNeedsOptInAndFiltersPoorOrStaleSamples() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        var record = CleanupSessionRecord(id: UUID(), started_at: Date().timeIntervalSince1970 - 5, started_uptime: 1)
        let file = directory.appendingPathComponent("cleanup-sessions.json")
        try JSONEncoder().encode([record]).write(to: file)
        let store = CleanupSessionStore(); try store.bind(directory: directory)
        let location = CLLocation(coordinate: .init(latitude: 37, longitude: -122), altitude: 10, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date())
        store.accept([location]); XCTAssertTrue(store.current!.route.isEmpty)
        record.record_route = true
        try JSONEncoder().encode([record]).write(to: file)
        let optedIn = CleanupSessionStore(); try optedIn.bind(directory: directory)
        optedIn.accept([location]); XCTAssertEqual(optedIn.current?.route.count, 1)
        optedIn.accept([location]); XCTAssertEqual(optedIn.current?.route.count, 1)
        let stale = CLLocation(coordinate: location.coordinate, altitude: 10, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(-60))
        optedIn.accept([stale]); XCTAssertEqual(optedIn.current?.route.count, 1)
        try optedIn.stop(); optedIn.accept([location]); XCTAssertEqual(optedIn.current?.route.count, 1)
    }
}

extension CleanupSessionTests {
    func testWatchStopDeliveredBeforeStartCannotReopenFinishedWalk() throws {
        let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: folder) }
        let store = CleanupSessionStore(), id = UUID(); try store.bind(directory: folder)
        try store.applyWatchEvent(id: id, active: false, startedAt: 100, eventAt: 200)
        try store.applyWatchEvent(id: id, active: true, startedAt: 100, eventAt: 100)
        XCTAssertNil(store.activeID)
        XCTAssertEqual(store.current?.started_at, 100)
        XCTAssertEqual(store.current?.ended_at, 200)
        XCTAssertEqual(store.records.count, 1)
    }
}


extension CleanupSessionTests {
    func testWalkStartsWithFormDetailsAndSelectedLocationOptionsAtomically() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let store = CleanupSessionStore(locationEnabled: false); try store.bind(directory: directory)
        XCTAssertThrowsError(try store.start(name: String(repeating: "x", count: 121), markLocation: true, recordRoute: true))
        XCTAssertNil(store.activeID)
        try store.start(name: "Shoreline", description: "Afternoon pickup", markLocation: true, recordRoute: true)
        XCTAssertEqual(store.current?.name, "Shoreline")
        XCTAssertEqual(store.current?.description, "Afternoon pickup")
        XCTAssertTrue(store.current!.record_route)
        XCTAssertEqual(store.routeStatus, "Waiting for the first GPS location.")
        let location = CLLocation(coordinate: .init(latitude: 37, longitude: -122), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(0.01))
        store.accept([location])
        XCTAssertEqual(store.current?.marked_location?.latitude, 37)
        XCTAssertEqual(store.current?.route.count, 1)
        XCTAssertEqual(store.routeStatus, "1 GPS locations saved along this walk.")
        try store.stop()
        try store.start(name: "Second walk", markLocation: false, recordRoute: false)
        XCTAssertEqual(store.current?.name, "Second walk")
        XCTAssertEqual(store.records.count, 2)
        XCTAssertFalse(store.current!.record_route)
        XCTAssertNil(store.current?.marked_location)
    }

    func testMetadataCloudStateTracksPendingFailureRetryAndAcknowledgement() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let store = CleanupSessionStore(locationEnabled: false); try store.bind(directory: directory)
        XCTAssertEqual(store.syncState(for: nil), .draft)
        try store.start()
        let id = try XCTUnwrap(store.activeID), revision = store.current!.revision
        XCTAssertEqual(store.syncState(for: store.current), .pending)
        store.beginSync(id); XCTAssertEqual(store.syncState(for: store.current), .syncing)
        store.failSync(id, revision: revision); XCTAssertEqual(store.syncState(for: store.current), .failed)
        store.beginSync(id); XCTAssertEqual(store.syncState(for: store.current), .syncing)
        try store.acknowledge(id: id, revision: revision)
        XCTAssertEqual(store.syncState(for: store.current), .synced)
        try store.edit(id: id, name: "Updated", description: "")
        XCTAssertEqual(store.syncState(for: store.current), .pending)
    }

    func testMultipleFullRecordingsGroupByWalkAndSortNewestFirst() {
        let firstWalk = CleanupSessionRecord(id: UUID(), started_at: 100, started_uptime: 1)
        let secondWalk = CleanupSessionRecord(id: UUID(), started_at: 200, started_uptime: 2)
        func full(_ walk: UUID?, _ time: Double) -> FullSessionRecording {
            .init(id: UUID(), directory: URL(fileURLWithPath: "/tmp/fixture"), createdAt: Date(timeIntervalSince1970: time), start: time, end: time + 1, cleanupSessionID: walk, finalized: true, uploaded: false)
        }
        let a = full(firstWalk.id, 110), b = full(firstWalk.id, 120), c = full(secondWalk.id, 210)
        let groups = FullRecordingGroup.make(recordings: [a, c, b], walks: [firstWalk, secondWalk])
        XCTAssertEqual(groups.count, 2)
        XCTAssertEqual(groups[0].recordings.map(\.id), [c.id])
        XCTAssertEqual(groups[1].recordings.map(\.id), [b.id, a.id])
    }
}

extension CleanupSessionTests {
    func testReadablePlaceIsCachedWithoutChangingRawCoordinatesOrRoute() async throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        var calls = 0
        let store = CleanupSessionStore(locationEnabled: false, placeLookup: { _ in calls += 1; return "Sunset District, San Francisco, CA" })
        try store.bind(directory: directory)
        try store.start(markLocation: true, recordRoute: true)
        let location = CLLocation(coordinate: .init(latitude: 37.75, longitude: -122.49), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(0.01))
        store.accept([location])
        let raw = try XCTUnwrap(store.current?.marked_location), route = store.current!.route
        for _ in 0..<100 { if store.placeName(for: store.current!) != nil { break }; try await Task.sleep(for: .milliseconds(10)) }
        XCTAssertEqual(store.placeName(for: store.current!), "Sunset District, San Francisco, CA")
        XCTAssertEqual(store.current?.marked_location, raw)
        XCTAssertEqual(store.current?.route, route)
        store.resolveMarkedPlaceIfNeeded()
        XCTAssertEqual(calls, 1)
        let restored = CleanupSessionStore(locationEnabled: false)
        try restored.bind(directory: directory)
        XCTAssertEqual(restored.placeName(for: restored.current!), "Sunset District, San Francisco, CA")
        XCTAssertEqual(restored.current?.marked_location, raw)
    }

    func testFailedLookupRetainsGPSAndDoesNotContinuouslyRetryRouteSamples() async throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        var calls = 0
        let store = CleanupSessionStore(locationEnabled: false, placeLookup: { _ in calls += 1; throw URLError(.notConnectedToInternet) })
        try store.bind(directory: directory); try store.start(markLocation: true, recordRoute: true)
        store.accept([CLLocation(coordinate: .init(latitude: 37, longitude: -122), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(0.01))])
        for _ in 0..<20 { await Task.yield() }
        store.resolveMarkedPlaceIfNeeded()
        XCTAssertNil(store.placeName(for: store.current!))
        XCTAssertEqual(store.current?.marked_location?.latitude, 37)
        XCTAssertEqual(store.current?.route.count, 1)
        XCTAssertEqual(calls, 1)
    }

    func testLatePlaceLookupCannotWriteIntoAnotherOwner() async throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let first = base.appendingPathComponent("first"), second = base.appendingPathComponent("second")
        for dir in [first, second] { try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true) }
        defer { try? FileManager.default.removeItem(at: base) }
        var reply: CheckedContinuation<String?, Never>?
        let store = CleanupSessionStore(locationEnabled: false, placeLookup: { _ in await withCheckedContinuation { reply = $0 } })
        try store.bind(directory: first); try store.start(markLocation: true, recordRoute: true)
        store.accept([CLLocation(coordinate: .init(latitude: 37, longitude: -122), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(0.01))])
        for _ in 0..<100 { if reply != nil { break }; try await Task.sleep(for: .milliseconds(10)) }
        XCTAssertNotNil(reply)
        try store.bind(directory: second)
        reply?.resume(returning: "Wrong owner’s city")
        for _ in 0..<20 { await Task.yield() }
        XCTAssertTrue(store.records.isEmpty)
        XCTAssertFalse(FileManager.default.fileExists(atPath: second.appendingPathComponent("cleanup-place-names.json").path))
    }

    func testWatchStartAutomaticallyRequestsMarkAndRoute() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let store = CleanupSessionStore(locationEnabled: false)
        try store.bind(directory: directory)
        let now = Date().timeIntervalSince1970
        try store.applyWatchEvent(id: UUID(), active: true, startedAt: now - 1, eventAt: now)
        store.accept([CLLocation(coordinate: .init(latitude: 37, longitude: -122), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date())])
        XCTAssertTrue(store.current!.record_route)
        XCTAssertNotNil(store.current?.marked_location)
        XCTAssertEqual(store.current?.route.count, 1)
    }

    func testReadableAreaPrefersNeighborhoodAndRemovesDuplicateNames() {
        XCTAssertEqual(CleanupPlaceResolver.areaName(neighborhood: "Sunset", city: "San Francisco", region: "CA", country: "United States"), "Sunset, San Francisco, CA")
        XCTAssertEqual(CleanupPlaceResolver.areaName(neighborhood: "San Francisco", city: "san francisco", region: "CA", country: nil), "San Francisco, CA")
        XCTAssertNil(CleanupPlaceResolver.areaName(neighborhood: nil, city: " ", region: nil, country: "United States"))
        XCTAssertNil(CleanupPlaceResolver.areaName(neighborhood: nil, city: nil, region: "California", country: "United States"))
        XCTAssertNil(CleanupPlaceResolver.cityName(city: nil, context: "United States", country: "United States"))
        XCTAssertNil(CleanupPlaceResolver.cityName(city: "United States", context: "United States", country: "United States"))
        XCTAssertEqual(CleanupPlaceResolver.cityName(city: "San Francisco", context: "San Francisco, CA", country: "United States"), "San Francisco, CA")
        XCTAssertNil(CleanupPlaceResolver.areaName(neighborhood: nil, city: nil, region: nil, country: nil))
    }
}


extension CleanupSessionTests {
    func testOldCountryOnlyCacheDoesNotHideCoordinates() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        var record = CleanupSessionRecord(id: UUID(), started_at: 1, started_uptime: 1)
        let point = CleanupLocation(latitude: 37, longitude: -122, accuracy_m: 5, altitude_m: 0, timestamp: 2, uptime: 2)
        record.marked_location = point
        try JSONEncoder().encode([record]).write(to: directory.appendingPathComponent("cleanup-sessions.json"))
        let raw = try JSONSerialization.jsonObject(with: JSONEncoder().encode(point))
        let cache: [String: Any] = [record.id.uuidString: ["location": raw, "name": "United States"]]
        try JSONSerialization.data(withJSONObject: cache).write(to: directory.appendingPathComponent("cleanup-place-names.json"))
        let store = CleanupSessionStore(locationEnabled: false); try store.bind(directory: directory)
        XCTAssertNil(store.placeName(for: store.current!))
        XCTAssertEqual(store.current?.marked_location, point)
    }
}
