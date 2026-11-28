import SwiftUI

struct CleanupSessionView: View {
    @ObservedObject var store: CleanupSessionStore
    var startsFullRecording = false
    var onStarted: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    @State private var name = "Cleanup walk"
    @State private var draftRoute = true
    @State private var draftMark = true
    @State private var details = ""
    @State private var error = ""
    @State private var confirmStop = false
    private var active: CleanupSessionRecord? { store.records.first { $0.id == store.activeID } }
    var body: some View {
        NavigationStack {
            Form {
                Section(active == nil ? "New cleanup walk" : "Cleanup walk active") {
                    TextField("Session name", text: $name).accessibilityIdentifier("cleanupName")
                    TextField("Description of the cleanup event", text: $details, axis: .vertical).lineLimit(1...3)
                        .accessibilityIdentifier("cleanupDescription")
                    if let session = active {
                        Button("Save details") {
                            do { try store.edit(id: session.id, name: name, description: details); error = "" }
                            catch { self.error = "Use up to 120 characters for the name and 4,000 for the description." }
                        }
                    } else { Text("Details are saved when you start the walk.").font(.footnote) }
                }
                Section("Location") {
                    if active == nil {
                        Toggle("Mark current location", isOn: $draftMark).accessibilityIdentifier("markStartingLocation")
                    } else {
                        Button("Mark current location", systemImage: "mappin.and.ellipse") { store.markLocation() }
                        if let sessionForLocation = active, let point = sessionForLocation.marked_location {
                            Text(store.placeName(for: sessionForLocation) ?? String(format: "%.5f, %.5f", point.latitude, point.longitude))
                                .font(.caption).accessibilityIdentifier("cleanupPlaceName")
                            Text("Accuracy ±\(Int(point.accuracy_m)) m").font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                    Toggle("Record walking route", isOn: Binding(get: {
                        active == nil ? draftRoute : (active?.record_route ?? false)
                    }, set: { enabled in
                        if active == nil { draftRoute = enabled } else { store.setRoute(enabled) }
                    })).accessibilityIdentifier("recordWalkingRoute")
                    if active != nil { Text(store.routeStatus).accessibilityIdentifier("routeStatus") }
                    else { Text("Your selected location options begin when you start the walk.").font(.footnote) }
                }
                if active != nil {
                    Section { Button("Stop cleanup walk", role: .destructive) { confirmStop = true } }
                } else {
                    Section {
                        Button(startsFullRecording ? "Start walk & full recording" : "Start cleanup walk", systemImage: "leaf.fill") {
                            do {
                                try store.start(name: name, description: details, markLocation: draftMark, recordRoute: draftRoute)
                                error = ""
                                onStarted?()
                                if startsFullRecording { dismiss() }
                            } catch { self.error = "Could not start the walk. Check the name and description lengths and try again." }
                        }.accessibilityIdentifier("startCleanupWalk")
                    }
                }
                if !store.message.isEmpty { Text(store.message).font(.footnote) }
                if !error.isEmpty { Text(error).foregroundStyle(.red) }
            }
            .navigationTitle("Cleanup session").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { CleanupMetadataSyncIcon(state: store.syncState(for: active)) }
                ToolbarItem(placement: .confirmationAction) { Button(startsFullRecording ? "Cancel" : "Done") { dismiss() } }
            }
            .task { loadDetails(); store.resumeRouteIfRequested() }
            .onChange(of: store.activeID) { _, _ in loadDetails() }
            .confirmationDialog("Stop cleanup walk?", isPresented: $confirmStop, titleVisibility: .visible) {
                Button("Stop cleanup walk", role: .destructive) { do { try store.stop() } catch { self.error = "Could not save the end of this walk." } }
            }
        }
    }
    private func loadDetails() { name = active?.name ?? "Cleanup walk"; details = active?.description ?? "" }
}

/// Shared by camera and Simulator UI checks. Canceling the form starts nothing.
struct FullRecordingStartFlow: ViewModifier {
    @ObservedObject var store: CleanupSessionStore
    @Binding var presented: Bool
    let startRecording: () -> Void
    @State private var startAfterDismiss = false
    func body(content: Content) -> some View {
        content.sheet(isPresented: $presented, onDismiss: {
            if startAfterDismiss { startAfterDismiss = false; startRecording() }
        }) {
            CleanupSessionView(store: store, startsFullRecording: true) { startAfterDismiss = true }
        }
    }
}


struct CleanupMetadataSyncIcon: View {
    let state: CleanupMetadataSyncState
    private var loading: Bool { state == .pending || state == .syncing }
    private var symbol: String {
        switch state {
        case .draft: "icloud"
        case .pending, .syncing: "icloud.and.arrow.up"
        case .failed: "exclamationmark.icloud"
        case .synced: "checkmark.icloud"
        }
    }
    private var label: String {
        switch state {
        case .draft: "Cleanup walk not started"
        case .pending: "Cleanup details waiting to sync"
        case .syncing: "Syncing cleanup details"
        case .failed: "Cleanup details could not sync"
        case .synced: "Cleanup details synced"
        }
    }
    var body: some View {
        Image(systemName: symbol)
            .foregroundStyle(state == .failed ? Color.red : state == .synced ? Color.blue : Color.secondary)
            .symbolEffect(.pulse, options: .repeating, isActive: loading)
            .accessibilityLabel(label).accessibilityIdentifier("cleanupSyncStatus")
    }
}
