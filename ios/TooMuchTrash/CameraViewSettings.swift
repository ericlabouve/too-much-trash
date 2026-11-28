import SwiftUI

struct FrozenCameraModel: Identifiable {
    let id: String
    let name: String
    let frozenDate: String
    let events: String
    static let catalog = [FrozenCameraModel(id: "jaw-r59-independent-motion-alpha1", name: "R59 · Independent motion adds recall", frozenDate: "2026-11-27", events: "Squeeze, release")]
}
struct CameraViewConfiguration: Codable, Equatable {
    var modelEnabled = true
    var selectedModelID = FrozenCameraModel.catalog[0].id
    var fullRecordingButtonEnabled = true
    var runsModel: Bool { modelEnabled && FrozenCameraModel.catalog.contains { $0.id == selectedModelID } }
}
@MainActor final class CameraViewSettings: ObservableObject {
    @Published private(set) var configuration: CameraViewConfiguration
    private let defaults: UserDefaults
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        configuration = defaults.data(forKey: "cameraViewConfiguration").flatMap { try? JSONDecoder().decode(CameraViewConfiguration.self, from: $0) } ?? CameraViewConfiguration()
    }
    func update(_ edit: (inout CameraViewConfiguration) -> Void) {
        var next = configuration; edit(&next)
        guard let data = try? JSONEncoder().encode(next) else { return }
        defaults.set(data, forKey: "cameraViewConfiguration"); configuration = next
    }
}
struct CameraSettingsView: View {
    @ObservedObject var settings: CameraViewSettings
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section("Frozen model") {
                    Toggle("Show model predictions", isOn: Binding(get: { settings.configuration.modelEnabled }, set: { value in settings.update { $0.modelEnabled = value } }))
                        .accessibilityIdentifier("modelEnabled")
                    Picker("Model", selection: Binding(get: { settings.configuration.selectedModelID }, set: { value in settings.update { $0.selectedModelID = value } })) {
                        ForEach(FrozenCameraModel.catalog) { model in Text(model.name).tag(model.id) }
                    }
                    if let model = FrozenCameraModel.catalog.first(where: { $0.id == settings.configuration.selectedModelID }) {
                        LabeledContent("Frozen", value: model.frozenDate)
                        LabeledContent("Predicts", value: model.events)
                    }
                    Text("Predictions appear on the camera preview. Manual volume-button recording stays available.").font(.footnote)
                }
                Section("Camera controls") {
                    Toggle("Full recording button", isOn: Binding(get: { settings.configuration.fullRecordingButtonEnabled }, set: { value in settings.update { $0.fullRecordingButtonEnabled = value } }))
                        .accessibilityIdentifier("fullRecordingButtonEnabled")
                }
            }.navigationTitle("Camera view").navigationBarTitleDisplayMode(.inline)
                .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
        }
    }
}
