import AppKit
import AVFoundation

@main struct ContactSheet {
    static func main() throws {
        let args = CommandLine.arguments
        guard args.count == 3 else { fatalError("Expected video and output JPEG") }
        let asset = AVURLAsset(url: URL(fileURLWithPath: args[1]))
        let duration = CMTimeGetSeconds(asset.duration)
        guard duration.isFinite && duration > 0 else { fatalError("Invalid video duration") }
        let count = min(64, max(2, Int(ceil(duration * 2))))
        let width = 1280, cellW = 320, cellH = 262, rows = (count + 3) / 4
        let image = NSImage(size: NSSize(width: width, height: rows * cellH))
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.requestedTimeToleranceBefore = CMTime(seconds: 0.05, preferredTimescale: 600)
        generator.requestedTimeToleranceAfter = CMTime(seconds: 0.05, preferredTimescale: 600)
        image.lockFocus()
        NSColor.black.setFill(); NSRect(x: 0, y: 0, width: width, height: rows * cellH).fill()
        for index in 0..<count {
            let time = min(max(0, duration - 0.05), Double(index) * duration / Double(count - 1))
            var actual = CMTime.zero
            let frame = try generator.copyCGImage(at: CMTime(seconds: time, preferredTimescale: 600), actualTime: &actual)
            let origin = NSPoint(x: (index % 4) * cellW, y: (rows - 1 - index / 4) * cellH)
            NSImage(cgImage: frame, size: NSSize(width: frame.width, height: frame.height))
                .draw(in: NSRect(x: origin.x, y: origin.y + 22, width: CGFloat(cellW), height: 240))
            let label = String(format: "%.3f s", CMTimeGetSeconds(actual))
            label.draw(at: NSPoint(x: origin.x + 5, y: origin.y + 3), withAttributes: [.font: NSFont.monospacedSystemFont(ofSize: 14, weight: .medium), .foregroundColor: NSColor.white])
        }
        image.unlockFocus()
        guard let data = image.tiffRepresentation, let bitmap = NSBitmapImageRep(data: data),
              let png = bitmap.representation(using: .jpeg, properties: [.compressionFactor: 0.8]) else { fatalError("Cannot encode frames") }
        try png.write(to: URL(fileURLWithPath: args[2]))
    }
}
