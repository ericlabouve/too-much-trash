import Accelerate
import CoreVideo

/// Preserve native landscape orientation and full 4:3 view. Avoid RGB/gamma
/// conversion: recorded-media gray is derived from the camera's luma plane.
enum JawGrayConverter {
    static func make(_ pixels: CVPixelBuffer) -> [UInt8]? {
        let format = CVPixelBufferGetPixelFormatType(pixels)
        guard format == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange || format == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
              CVPixelBufferGetWidth(pixels) * 3 == CVPixelBufferGetHeight(pixels) * 4,
              CVPixelBufferLockBaseAddress(pixels, .readOnly) == kCVReturnSuccess else { return nil }
        defer { CVPixelBufferUnlockBaseAddress(pixels, .readOnly) }
        guard let base = CVPixelBufferGetBaseAddressOfPlane(pixels, 0) else { return nil }
        let width = CVPixelBufferGetWidthOfPlane(pixels, 0), height = CVPixelBufferGetHeightOfPlane(pixels, 0)
        var source = vImage_Buffer(data: base, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: CVPixelBufferGetBytesPerRowOfPlane(pixels, 0))
        var gray = [UInt8](repeating: 0, count: 320 * 240)
        let result = gray.withUnsafeMutableBytes { bytes -> vImage_Error in
            var target = vImage_Buffer(data: bytes.baseAddress!, height: 240, width: 320, rowBytes: 320)
            return vImageScale_Planar8(&source, &target, nil, vImage_Flags(kvImageHighQualityResampling))
        }
        guard result == kvImageNoError else { return nil }
        if format == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange {
            gray = gray.map { UInt8(clamping: Int((Double(Int($0) - 16) * 255 / 219).rounded())) }
        }
        return gray
    }
}
