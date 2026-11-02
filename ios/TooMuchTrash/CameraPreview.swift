import AVFoundation
import AVKit
import ARKit
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraController

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.previewLayer.session = camera.session
        view.previewLayer.videoGravity = .resizeAspectFill
        let interaction = AVCaptureEventInteraction(primary: { event in
            handle(event, source: "primary")
        }, secondary: { event in
            handle(event, source: "secondary")
        })
        interaction.isEnabled = camera.isReady && !camera.isFinishing
        view.addInteraction(interaction)
        view.captureInteraction = interaction
        return view
    }

    func updateUIView(_ view: PreviewView, context: Context) {
        view.captureInteraction?.isEnabled = camera.isReady && !camera.isFinishing
    }

    private func handle(_ event: AVCaptureEvent, source: String) {
        switch event.phase {
        case .began: camera.press(source)
        case .ended, .cancelled: camera.release(source)
        @unknown default: camera.release(source)
        }
    }
}

struct EpisodeCameraPreview: UIViewRepresentable {
    @ObservedObject var camera: EpisodeCameraController

    func makeUIView(context: Context) -> EpisodePreviewView {
        let view = EpisodePreviewView()
        if let session = camera.session { view.scene.session = session }
        view.scene.automaticallyUpdatesLighting = false
        let interaction = AVCaptureEventInteraction(primary: { event in
            handle(event, source: "primary")
        }, secondary: { event in
            handle(event, source: "secondary")
        })
        interaction.isEnabled = camera.isReady || camera.recordingStartedAt != nil
        view.addInteraction(interaction)
        view.captureInteraction = interaction
        return view
    }

    func updateUIView(_ view: EpisodePreviewView, context: Context) {
        if let session = camera.session, view.scene.session !== session { view.scene.session = session }
        // Keep receiving the release if readiness drops during a held trigger.
        view.captureInteraction?.isEnabled = camera.isReady || camera.recordingStartedAt != nil
    }

    private func handle(_ event: AVCaptureEvent, source: String) {
        switch event.phase {
        case .began: camera.press(source)
        case .ended: camera.release(source)
        case .cancelled: camera.cancel(source)
        @unknown default: camera.cancel(source)
        }
    }
}

final class EpisodePreviewView: UIView {
    let scene = ARSCNView()
    var captureInteraction: AVCaptureEventInteraction?
    override init(frame: CGRect) {
        super.init(frame: frame)
        scene.frame = bounds
        scene.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(scene)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) is not supported") }
}

final class PreviewView: UIView {
    override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
    var previewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }
    var captureInteraction: AVCaptureEventInteraction?

    override func layoutSubviews() {
        super.layoutSubviews()
        if let connection = previewLayer.connection, connection.isVideoRotationAngleSupported(90) {
            connection.videoRotationAngle = 90
        }
    }
}
