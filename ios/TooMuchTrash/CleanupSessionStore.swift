import Foundation
import Combine
import CoreLocation
import UIKit

enum CleanupMetadataSyncState: Equatable { case draft, pending, syncing, failed, synced }

struct CleanupLocation: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let accuracy_m: Double
    let altitude_m: Double
    let timestamp: Double
    let uptime: Double
}
private struct CachedCleanupPlace: Codable {
    var localityVerified: Bool?
    let location: CleanupLocation
    let name: String
}

struct CleanupSessionRecord: Codable, Identifiable, Equatable {
    let id: UUID
    var revision = 1
    var name = "Cleanup walk"
    var description = ""
    let started_at: Double
    let started_uptime: Double?
    var start_time_reference: String?
    var ended_at: Double?
    var record_route = false
    var marked_location: CleanupLocation?
    var route: [CleanupLocation] = []
    var route_notes: [String] = []
    var acknowledged_revision = 0
    var needsSync: Bool { revision > acknowledged_revision }
}

@MainActor final class CleanupSessionStore: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var records: [CleanupSessionRecord] = []
    @Published private(set) var message = ""
    @Published private var syncFailures: [UUID: Int] = [:]
    @Published private var syncingID: UUID?
    func syncState(for record: CleanupSessionRecord?) -> CleanupMetadataSyncState {
        guard let record else { return .draft }
        guard record.needsSync else { return .synced }
        if syncingID == record.id { return .syncing }
        return syncFailures[record.id] == record.revision ? .failed : .pending
    }
    func beginSync(_ id: UUID) { syncingID = id }
    func failSync(_ id: UUID, revision: Int) { syncFailures[id] = revision; syncingID = nil }

    @Published private var placeNames: [String: CachedCleanupPlace] = [:]
    private var placeTask: Task<Void, Never>?
    private var placeGeneration = UUID()
    private var lastPlaceAttempt: Date = .distantPast
    private let placeLookup: (@MainActor (CLLocation) async throws -> String?)?
    func placeName(for record: CleanupSessionRecord) -> String? {
        guard let cached = placeNames[record.id.uuidString], cached.location == record.marked_location, cached.localityVerified == true else { return nil }
        return cached.name
    }
    private var file: URL?
    private var ownerDirectory: URL?
    private var manager: CLLocationManager?
    private var marking = false
    private let locationEnabled: Bool
    init(locationEnabled: Bool = true, placeLookup: (@MainActor (CLLocation) async throws -> String?)? = nil) {
        self.locationEnabled = locationEnabled
        if let placeLookup { self.placeLookup = placeLookup }
        else if locationEnabled { self.placeLookup = { try await CleanupPlaceResolver.name(for: $0) } }
        else { self.placeLookup = nil }
        super.init()
    }
    var routeStatus: String {
        guard let session = current, activeID != nil else { return "No active cleanup walk." }
        guard session.record_route else { return "Route recording is off." }
        return session.route.isEmpty ? "Waiting for the first GPS location." : "\(session.route.count) GPS locations saved along this walk."
    }
    var onChange: (() -> Void)?
    var activeID: UUID? { records.last(where: { $0.ended_at == nil })?.id }
    var current: CleanupSessionRecord? { records.last(where: { $0.ended_at == nil }) ?? records.last }
    func bind(directory: URL) throws {
        guard ownerDirectory != directory else { return }
        manager?.stopUpdatingLocation(); marking = false
        placeTask?.cancel(); placeTask = nil; placeGeneration = UUID(); lastPlaceAttempt = .distantPast
        let url = directory.appendingPathComponent("cleanup-sessions.json")
        let loaded = FileManager.default.fileExists(atPath: url.path) ? try JSONDecoder().decode([CleanupSessionRecord].self, from: Data(contentsOf: url)) : []
        ownerDirectory = directory; file = url; records = loaded; syncFailures = [:]; syncingID = nil
        let labelsFile = directory.appendingPathComponent("cleanup-place-names.json")
        placeNames = (try? JSONDecoder().decode([String: CachedCleanupPlace].self, from: Data(contentsOf: labelsFile))) ?? [:]
        message = ""
        // Background route capture must be explicitly resumed in the foreground.
        if current?.record_route == true, activeID != nil {
            message = "Open Cleanup session to resume route recording."
            noteLocation("route_interrupted_before_foreground_resume")
        }
    }
    private func save(_ values: [CleanupSessionRecord]) throws {
        guard let file else { throw ClientError.storage }
        try JSONEncoder().encode(values).write(to: file, options: .atomic)
        try CaptureQueue.protect(file)
        records = values; onChange?()
    }
    func start(id: UUID = UUID(), at time: Double = Date().timeIntervalSince1970, fromWatch: Bool = false, name: String = "Cleanup walk", description: String = "", markLocation: Bool = false, recordRoute: Bool = false) throws {
        guard !records.contains(where: { $0.id == id }) else { return } // Watch retries are idempotent.
        guard activeID == nil, name.count <= 120, description.count <= 4000 else { throw ClientError.validation }
        let uptime = ProcessInfo.processInfo.systemUptime + (fromWatch ? time - Date().timeIntervalSince1970 : 0)
        var record = CleanupSessionRecord(id: id, started_at: time, started_uptime: uptime >= 0 ? uptime : nil)
        record.name = name; record.description = description; record.record_route = recordRoute
        record.start_time_reference = fromWatch ? "watch_wall_clock_estimate" : "phone_callback_uptime"
        try save(records + [record])
        placeTask?.cancel(); placeTask = nil; placeGeneration = UUID(); lastPlaceAttempt = .distantPast
        marking = markLocation
        if markLocation || recordRoute { beginLocation() }
    }
    func applyWatchEvent(id: UUID, active: Bool, startedAt: Double, eventAt: Double) throws {
        guard startedAt.isFinite, eventAt.isFinite, startedAt >= 0, eventAt >= 0 else { throw ClientError.validation }
        if active { try start(id: id, at: startedAt, fromWatch: true, markLocation: true, recordRoute: true) }
        else {
            if !records.contains(where: { $0.id == id }) { try start(id: id, at: startedAt, fromWatch: true) }
            try stop(id: id, at: eventAt)
        }
    }
    func stop(id: UUID? = nil, at time: Double = Date().timeIntervalSince1970) throws {
        guard let target = id ?? activeID, let i = records.firstIndex(where: { $0.id == target }), records[i].ended_at == nil else { return }
        var next = records; next[i].ended_at = max(time, next[i].started_at); next[i].revision += 1
        try save(next); manager?.stopUpdatingLocation(); marking = false
    }
    func edit(id: UUID, name: String, description: String) throws {
        guard let i = records.firstIndex(where: { $0.id == id }), name.count <= 120, description.count <= 4000 else { throw ClientError.validation }
        var next = records; next[i].name = name; next[i].description = description; next[i].revision += 1; try save(next)
    }
    func acknowledge(id: UUID, revision: Int) throws {
        guard let i = records.firstIndex(where: { $0.id == id }) else { return }
        var next = records; next[i].acknowledged_revision = min(revision, next[i].revision); try save(next)
        syncFailures[id] = nil; syncingID = nil
    }
    func setRoute(_ enabled: Bool) {
        guard let id = activeID, let i = records.firstIndex(where: { $0.id == id }) else { return }
        var next = records; next[i].record_route = enabled; next[i].revision += 1
        do { try save(next) } catch { message = "Could not save route preference."; return }
        if enabled { beginLocation() } else { manager?.stopUpdatingLocation(); message = "Route recording stopped." }
    }
    func markLocation() { guard activeID != nil else { return }; placeTask?.cancel(); placeTask = nil; placeGeneration = UUID(); lastPlaceAttempt = .distantPast; marking = true; message = "Waiting for the current GPS location."; beginLocation() }
    func resumeRouteIfRequested() {
        if activeID != nil, current?.record_route == true { beginLocation() }
        resolveMarkedPlaceIfNeeded()
    }
    func pauseForAccountChange() { placeTask?.cancel(); placeTask = nil; placeGeneration = UUID(); placeNames = [:]; manager?.stopUpdatingLocation(); ownerDirectory = nil; file = nil; records = []; marking = false; syncFailures = [:]; syncingID = nil }
    private func noteLocation(_ reason: String) {
        guard let id = activeID, let i = records.firstIndex(where: { $0.id == id }), records[i].route_notes.last != reason else { return }
        var next = records; next[i].route_notes.append(reason)
        if next[i].route_notes.count > 100 { next[i].route_notes.removeFirst() }
        next[i].revision += 1
        try? save(next)
    }
    private func beginLocation() {
        guard locationEnabled else { return }
        guard UIApplication.shared.applicationState == .active else { message = "Open the phone app to start location recording."; return }
        if manager == nil {
            let m = CLLocationManager(); m.delegate = self; m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            m.distanceFilter = 5; m.activityType = .fitness; manager = m
        }
        guard let manager else { return }
        switch manager.authorizationStatus {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.allowsBackgroundLocationUpdates = current?.record_route == true
            manager.showsBackgroundLocationIndicator = current?.record_route == true
            manager.pausesLocationUpdatesAutomatically = false
            if current?.record_route == true { manager.startUpdatingLocation(); message = "Recording walking route." }
            else if marking { manager.requestLocation() }
        default:
            message = "Location access is off. Enable it in iPhone Settings to mark a location or record a route."
            noteLocation("location_permission_denied_or_restricted")
        }
    }
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in if self.activeID != nil, self.marking || self.current?.record_route == true { self.beginLocation() } }
    }
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in self.accept(locations) }
    }
    func accept(_ locations: [CLLocation]) {
        guard let id = activeID, let i = records.firstIndex(where: { $0.id == id }) else { return }
        var next = records; var changed = false
        for location in locations where location.horizontalAccuracy >= 0 && location.horizontalAccuracy <= 100000 && location.timestamp.timeIntervalSince1970 >= records[i].started_at && abs(location.timestamp.timeIntervalSinceNow) <= 30 {
            let point = CleanupLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, accuracy_m: location.horizontalAccuracy, altitude_m: location.altitude, timestamp: location.timestamp.timeIntervalSince1970, uptime: ProcessInfo.processInfo.systemUptime + location.timestamp.timeIntervalSinceNow)
            if marking {
                next[i].marked_location = point; marking = false; changed = true
                message = "Location marked (±\(Int(point.accuracy_m)) m)."
            }
            if point.accuracy_m > 100 && next[i].record_route { message = "Recording approximate route (±\(Int(point.accuracy_m)) m)." }
            if next[i].record_route && (next[i].route.last.map { point.timestamp - $0.timestamp >= 5 } ?? true) {
                guard next[i].route.count < 100000 else { message = "Route is full; saved points retained."; break }
                next[i].route.append(point); changed = true
            }
        }
        if changed {
            next[i].revision += 1
            do { try save(next); resolveMarkedPlaceIfNeeded() }
            catch { message = "Could not save location; retained earlier points." }
        }
    }
    /// Cached per owner and exact marked point. Late lookup results cannot rename another walk/owner.
    func resolveMarkedPlaceIfNeeded() {
        guard let record = current, let point = record.marked_location, placeName(for: record) == nil,
              let lookup = placeLookup, let directory = ownerDirectory,
              Date().timeIntervalSince(lastPlaceAttempt) >= 60 else { return }
        if placeTask != nil { return }
        lastPlaceAttempt = Date()
        let generation = UUID(); placeGeneration = generation
        let location = CLLocation(latitude: point.latitude, longitude: point.longitude)
        let id = record.id
        placeTask = Task { @MainActor [weak self] in
            defer { if self?.placeGeneration == generation { self?.placeTask = nil } }
            do {
                let result = try await OperationDeadline.run(seconds: 10) { try await lookup(location) }
                try Task.checkCancellation()
                guard let self, self.placeGeneration == generation, self.ownerDirectory == directory,
                      self.records.first(where: { $0.id == id })?.marked_location == point,
                      let name = result?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return }
                var names = self.placeNames
                names[id.uuidString] = CachedCleanupPlace(localityVerified: true, location: point, name: String(name.prefix(240)))
                let file = directory.appendingPathComponent("cleanup-place-names.json")
                try JSONEncoder().encode(names).write(to: file, options: .atomic)
                try CaptureQueue.protect(file)
                self.placeNames = names
            } catch { /* Coordinates and route remain usable offline. Retry on a later foreground visit. */ }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor in
            self.message = "Location temporarily unavailable; saved route retained."
            self.noteLocation("location_updates_unavailable")
        }
    }
}
