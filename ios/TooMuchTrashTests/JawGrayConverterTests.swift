import XCTest
import CoreVideo
@testable import TooMuchTrash

final class JawGrayConverterTests: XCTestCase {
    func testLumaRangeAndOrientation() throws {
        for (format, low, high) in [(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange, UInt8(0), UInt8(255)),
                                  (kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, UInt8(16), UInt8(235))] {
            var buffer: CVPixelBuffer?
            XCTAssertEqual(CVPixelBufferCreate(nil, 640, 480, format, nil, &buffer), kCVReturnSuccess)
            let pixels = try XCTUnwrap(buffer)
            CVPixelBufferLockBaseAddress(pixels, [])
            let base = try XCTUnwrap(CVPixelBufferGetBaseAddressOfPlane(pixels, 0))
            let stride = CVPixelBufferGetBytesPerRowOfPlane(pixels, 0)
            for y in 0..<480 { memset(base.advanced(by: y * stride), y < 240 ? Int32(low) : Int32(high), 640) }
            CVPixelBufferUnlockBaseAddress(pixels, [])
            let gray = try XCTUnwrap(JawGrayConverter.make(pixels))
            XCTAssertEqual(gray.count, 320 * 240)
            XCTAssertEqual(gray[10 * 320 + 10], 0)
            XCTAssertEqual(gray[230 * 320 + 10], 255)
        }
    }
}
