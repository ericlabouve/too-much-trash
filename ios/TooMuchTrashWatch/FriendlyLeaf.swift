import SwiftUI

/// A small native illustration keeps the approved friendly leaf motif crisp at Watch sizes.
struct FriendlyLeaf: View {
    var body: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            let h = proxy.size.height
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: w * 0.12, y: h * 0.87))
                    path.addCurve(to: CGPoint(x: w * 0.90, y: h * 0.04), control1: CGPoint(x: -w * 0.13, y: h * 0.29), control2: CGPoint(x: w * 0.45, y: h * 0.22))
                    path.addCurve(to: CGPoint(x: w * 0.12, y: h * 0.87), control1: CGPoint(x: w * 1.12, y: h * 0.69), control2: CGPoint(x: w * 0.55, y: h * 0.97))
                }.fill(Color(red: 0.49, green: 1, blue: 0.04))
                Path { path in
                    path.move(to: CGPoint(x: w * 0.08, y: h * 0.98))
                    path.addQuadCurve(to: CGPoint(x: w * 0.70, y: h * 0.34), control: CGPoint(x: w * 0.22, y: h * 0.64))
                }.stroke(Color.green.opacity(0.7), style: StrokeStyle(lineWidth: max(1, w * 0.07), lineCap: .round))
                HStack(spacing: w * 0.17) {
                    Capsule().frame(width: w * 0.07, height: h * 0.08)
                    Capsule().frame(width: w * 0.07, height: h * 0.08)
                }.foregroundStyle(.black).position(x: w * 0.51, y: h * 0.53)
                Path { path in
                    path.move(to: CGPoint(x: w * 0.42, y: h * 0.64))
                    path.addQuadCurve(to: CGPoint(x: w * 0.62, y: h * 0.62), control: CGPoint(x: w * 0.54, y: h * 0.77))
                }.stroke(.black, style: StrokeStyle(lineWidth: max(1, w * 0.06), lineCap: .round))
            }
        }.accessibilityHidden(true)
    }
}
