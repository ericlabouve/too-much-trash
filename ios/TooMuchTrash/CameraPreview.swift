import AVFoundation
import AVKit
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
