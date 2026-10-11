import SwiftUI

struct ContentView: View {
    private let ink = Color(red: 0.09, green: 0.20, blue: 0.17)
    private let moss = Color(red: 0.34, green: 0.49, blue: 0.40)

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.95, blue: 0.91)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("TOO MUCH TRASH / FIELD STUDIO")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .tracking(2)
                        .foregroundStyle(moss)

                    Text("↗")
                        .font(.system(size: 34))
                        .frame(width: 54, height: 54)
                        .background(Color(red: 0.78, green: 0.87, blue: 0.74))
                        .clipShape(RoundedRectangle(cornerRadius: 18))

                    Text("Teach robots to pick up what we leave behind.")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .tracking(-2)
                        .foregroundStyle(ink)

                    Text("Collect real grasp attempts, learn from each outcome, and build toward cleaner shared spaces.")
                        .font(.system(size: 18))
                        .foregroundStyle(moss)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("WORKSPACE")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(2)
                            .foregroundStyle(moss)
                        Text("A place for every pickup attempt")
                            .font(.title2.bold())
                            .foregroundStyle(ink)
                        Text("Capture and review tools will grow here as the hardware takes shape.")
                            .foregroundStyle(moss)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding(24)
            }
        }
    }
}

#Preview {
    ContentView()
}
