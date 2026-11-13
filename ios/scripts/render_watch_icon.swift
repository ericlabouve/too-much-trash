// Compile with TooMuchTrashWatch/FriendlyLeaf.swift to reuse the dashboard artwork.
import SwiftUI
import AppKit

@main
struct RenderWatchIcon {
    @MainActor static func main() throws {
        guard CommandLine.arguments.count == 2 else {
            fatalError("Usage: render_watch_icon <output.png>")
        }
        let renderer = ImageRenderer(content:
            ZStack {
                Color.black
                FriendlyLeaf().frame(width: 740, height: 740)
            }.frame(width: 1024, height: 1024))
        renderer.scale = 1
        renderer.isOpaque = true
        guard let image = renderer.cgImage,
              let context = CGContext(data: nil, width: 1024, height: 1024, bitsPerComponent: 8,
                bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else { fatalError("Cannot render icon") }
        context.draw(image, in: CGRect(x: 0, y: 0, width: 1024, height: 1024))
        guard let opaque = context.makeImage(),
              let png = NSBitmapImageRep(cgImage: opaque).representation(using: .png, properties: [:]) else {
            fatalError("Cannot encode icon")
        }
        try png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
    }
}
