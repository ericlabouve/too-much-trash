import SwiftUI
import WatchConnectivity
import WatchKit

@MainActor
final class WatchModel: NSObject, ObservableObject, WCSessionDelegate {
    @Published var state: [String: Any] = [:]
    @Published var reachable = false
    @Published var message = ""
    private let session = WCSession.isSupported() ? WCSession.default : nil
    override init() {
        super.init()
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-watch-preview") {
            state = ["authorized": true, "score": 24, "synced": 12, "pending": 12,
                     "progress": 0.5, "quota": 0.5, "serverReachable": true,
                     "updated": Date().timeIntervalSince1970, "latestID": UUID().uuidString]
            reachable = true
            return
        }
        #endif
        session?.delegate = self
        session?.activate()
    }
    nonisolated func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        let context = session.receivedApplicationContext
        let connected = session.isReachable
        Task { @MainActor in self.state = context; self.reachable = connected }
    }
    nonisolated func sessionReachabilityDidChange(_ session: WCSession) {
        let connected = session.isReachable
        Task { @MainActor in self.reachable = connected }
    }
    nonisolated func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        Task { @MainActor in self.state = applicationContext }
    }
    func send(_ action: String, backend: Bool = false) {
        guard let session, session.isReachable else { message = "iPhone unavailable. Open the app on your iPhone."; return }
        var request: [String: Any] = ["action": action]
        if action == "undo", let id = state["latestID"] as? String { request["id"] = id; request["backend"] = backend }
        session.sendMessage(request, replyHandler: { reply in
            let result = reply["error"] as? String ?? (action == "sync" ? "Sync requested." : "Video deleted.")
            Task { @MainActor in self.message = result }
        }, errorHandler: { _ in Task { @MainActor in self.message = "Could not reach iPhone. Try again." } })
    }
}

@main
struct TooMuchTrashWatchApp: App {
    @WKApplicationDelegateAdaptor(CleanupAppDelegate.self) private var delegate
    @StateObject private var model = WatchModel()
    var body: some Scene { WindowGroup { Dashboard(model: model).environmentObject(CleanupAppDelegate.workout) } }
}

struct Dashboard: View {
    @ObservedObject var model: WatchModel
    @EnvironmentObject private var workout: CleanupWorkout
    #if DEBUG
    @State private var selectedPage = ProcessInfo.processInfo.arguments.contains("-watch-preview-actions") ? 1 : 0
    #else
    @State private var selectedPage = 0
    #endif
    @Environment(\.scenePhase) private var scenePhase
    @State private var countdown: Int?
    @State private var startTask: Task<Void, Never>?
    @State private var confirmStop = false
    @State private var confirmUndo = false
    @State private var quotaAlert = false
    @AppStorage("quotaAlertLevel") private var quotaAlertLevel = 2
    var body: some View {
        GeometryReader { geometry in
            if showsSession {
                TabView(selection: $selectedPage) {
                    dashboardPage(size: geometry.size).tag(0)
                    actionsPage(size: geometry.size).tag(1)
                }
                .tabViewStyle(.verticalPage)
            } else {
                startPage(size: geometry.size)
            }
        }
        .background(.black)
        .onDisappear { startTask?.cancel(); countdown = nil }
        .onChange(of: scenePhase) { _, phase in
            if phase == .background { startTask?.cancel(); countdown = nil }
        }
        .onChange(of: workout.active) { _, active in
            if active { selectedPage = 0 }
        }
        .confirmationDialog("Stop cleanup walk?", isPresented: $confirmStop, titleVisibility: .visible) {
            Button("Stop cleanup walk", role: .destructive) { workout.end() }
            Button("Keep walking", role: .cancel) {}
        } message: {
            Text("End this walking workout and save it to Health?")
        }
        .confirmationDialog("Delete the latest video?", isPresented: $confirmUndo, titleVisibility: .visible) {
            Button("Delete from iPhone", role: .destructive) { model.send("undo") }
            if model.state["dev"] as? Bool == true && model.state["latestSynced"] as? Bool == true {
                Button("Delete here and backend", role: .destructive) { model.send("undo", backend: true) }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            if let time = model.state["latestAt"] as? Double {
                Text("Latest local video: \(Date(timeIntervalSince1970: time), style: .time). The score decreases after deletion.")
            } else { Text("Delete the latest local video and decrease the score.") }
        }
        .onChange(of: model.state["quota"] as? Double) { _, quota in
            guard let quota else { quotaAlertLevel = 2; return }
            let level = quota <= 0 ? 0 : quota <= 0.1 ? 1 : 2
            if level < quotaAlertLevel { quotaAlert = true }
            quotaAlertLevel = level
        }
        .alert("Upload quota low", isPresented: $quotaAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text((model.state["quota"] as? Double ?? 1) <= 0 ? "Your upload quota is exhausted." : "10% or less of your upload quota remains.")
        }
    }

    private var showsSession: Bool {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-watch-preview-session") { return true }
        #endif
        return workout.active
    }

    private var displayedCountdown: Int? {
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        if let index = arguments.firstIndex(of: "-watch-preview-countdown"),
           arguments.indices.contains(index + 1), let value = Int(arguments[index + 1]), (1...3).contains(value) {
            return value
        }
        #endif
        return countdown
    }

    private func beginCountdown() {
        guard countdown == nil, !workout.busy else { return }
        countdown = 3
        startTask = Task { @MainActor in
            defer { countdown = nil; startTask = nil }
            do {
                for value in (1...3).reversed() {
                    countdown = value
                    try await Task.sleep(for: .seconds(1))
                }
                try Task.checkCancellation()
                await workout.start()
            } catch { /* Leaving the screen cancels a pending countdown. */ }
        }
    }

    private func startPage(size: CGSize) -> some View {
        let diameter = min(size.width * 0.79, size.height * 0.64)
        return VStack(spacing: 8) {
            Spacer(minLength: 0)
            Button { beginCountdown() } label: {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.08, green: 0.40, blue: 0.12).gradient)
                    Circle().strokeBorder(leafGreen.opacity(0.7), lineWidth: 2)
                    if let value = displayedCountdown {
                        Text("\(value)")
                            .font(.system(size: 80, weight: .heavy, design: .rounded))
                            .monospacedDigit().foregroundStyle(leafGreen)
                            .accessibilityLabel("Starting in \(value)")
                    } else {
                        FriendlyLeaf().frame(width: diameter * 0.70, height: diameter * 0.70)
                    }
                }
                .frame(width: diameter, height: diameter)
                .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .disabled(workout.busy || model.state["authorized"] as? Bool != true)
            .allowsHitTesting(displayedCountdown == nil)
            .accessibilityLabel("Press to start cleanup walk")
            .accessibilityIdentifier("watchStartCleanup")
            Text(displayedCountdown != nil ? "Get ready…" : workout.busy ? "Starting walk…" : "Press to start cleanup walk")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(leafGreen).multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            if model.state["authorized"] as? Bool != true {
                Text("Open Too Much Trash on your iPhone.")
                    .font(.caption2).multilineTextAlignment(.center)
            } else if !workout.message.isEmpty {
                Text(workout.message).font(.caption2).multilineTextAlignment(.center)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 10).padding(.top, 22).padding(.bottom, 6)
        .frame(width: size.width, height: size.height)
    }

    private let leafGreen = Color(red: 0.49, green: 1, blue: 0.04)
    private var score: Int { model.state["score"] as? Int ?? 0 }
    private var progress: Double { min(1, max(0, model.state["progress"] as? Double ?? 0)) }

    private var brand: some View {
        HStack(spacing: 4) {
            FriendlyLeaf().frame(width: 18, height: 22)
            Text("Too Much\nTrash")
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .lineSpacing(-1)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 62, alignment: .leading)
            Spacer(minLength: 4)
            Image(systemName: model.reachable ? "iphone.gen3.radiowaves.left.and.right" : "iphone.slash")
                .foregroundStyle(model.reachable ? leafGreen : .gray)
                .accessibilityLabel(model.reachable ? "iPhone reachable" : "iPhone unavailable")
            Image(systemName: model.state["serverReachable"] as? Bool == false ? "icloud.slash" : "icloud")
                .foregroundStyle(model.state["serverReachable"] as? Bool == true ? leafGreen : .gray)
                .accessibilityLabel(model.state["serverReachable"] as? Bool == true ? "Server reachable at last check" : "Server unavailable or not checked")
        }
        .font(.system(size: 14, weight: .medium))
        .frame(minHeight: 22)
        .accessibilityElement(children: .contain)
    }

    private func dashboardPage(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            brand.padding(.top, 20)
            if model.state["authorized"] as? Bool == true {
                Spacer(minLength: 0)
                HStack(alignment: .bottom, spacing: 2) {
                    VStack(alignment: .leading, spacing: -5) {
                        Text("\(score)")
                            .font(.system(size: 60, weight: .heavy, design: .rounded))
                            .foregroundStyle(leafGreen)
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .frame(height: 62, alignment: .leading)
                        Text("Recovered")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.7).lineLimit(1)
                    }
                    FriendlyLeaf().frame(width: 34, height: 43).rotationEffect(.degrees(17)).padding(.bottom, 3)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(score) recovered")
                Spacer(minLength: 0)
                HStack(spacing: 9) {
                    ZStack {
                        Circle().stroke(Color.blue.opacity(0.26), lineWidth: 5)
                        Circle().trim(from: 0, to: progress)
                            .stroke(Color.cyan, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                        Image(systemName: "icloud.and.arrow.up").font(.system(size: 15, weight: .medium))
                    }.frame(width: 34, height: 34)
                    VStack(alignment: .leading, spacing: 1) {
                        Text("\(model.state["synced"] as? Int ?? 0) / \(score) synced")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .minimumScaleFactor(0.7).lineLimit(1)
                        Text("\(model.state["pending"] as? Int ?? 0) pending")
                            .font(.system(size: 9)).foregroundStyle(.secondary)
                    }
                }.padding(.vertical, 3)
                Spacer(minLength: 0)
                quotaRow
                if workout.active { Text("Cleanup walk active").font(.system(size: 9)).foregroundStyle(leafGreen) }
            } else {
                Spacer()
                Image(systemName: "iphone.and.arrow.forward").font(.largeTitle).foregroundStyle(leafGreen)
                Text("Open Too Much Trash on your iPhone.").font(.caption).multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .padding(.horizontal, 7).padding(.top, 1).padding(.bottom, 5)
        .frame(width: size.width, height: size.height)
        .accessibilityIdentifier("watchDashboard")
    }

    private var quotaRow: some View {
        HStack(spacing: 4) {
            Image(systemName: "externaldrive").font(.system(size: 11))
            if let quota = model.state["quota"] as? Double {
                Text("\(Int((quota * 100).rounded(.down)))% quota left")
                    .font(.system(size: 10, weight: .semibold)).lineLimit(1).minimumScaleFactor(0.8)
                GeometryReader { proxy in
                    Capsule().fill(.yellow.opacity(0.2))
                        .overlay(alignment: .leading) {
                            Capsule().fill(.yellow).frame(width: proxy.size.width * min(1, max(0, quota)))
                        }
                }.frame(width: 38, height: 5)
            } else {
                Text(model.state["unlimited"] as? Bool == true ? "Unlimited quota" : "Quota unavailable")
                    .font(.system(size: 10, weight: .medium))
            }
        }.foregroundStyle(.yellow)
    }

    private func actionsPage(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Actions").font(.system(size: 25, weight: .bold, design: .rounded))
            if model.state["authorized"] as? Bool == true {
                Button { model.send("sync") } label: {
                    Label("Sync now", systemImage: "icloud.and.arrow.up")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.plain)
                .background(RoundedRectangle(cornerRadius: 18).fill(Color.blue.gradient))
                .accessibilityIdentifier("watchSyncNow")
                Button(role: .destructive) { confirmUndo = true } label: {
                    Label("Undo last", systemImage: "arrow.uturn.backward")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.plain)
                .background(RoundedRectangle(cornerRadius: 18).fill(Color.red.gradient))
                .disabled(model.state["latestID"] == nil)
                .accessibilityIdentifier("watchUndoLast")
                Button { confirmStop = true } label: {
                    Label("Stop cleanup walk", systemImage: "stop.fill")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .lineLimit(1).minimumScaleFactor(0.75).padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.plain)
                .background(RoundedRectangle(cornerRadius: 18).fill(Color.orange.gradient))
                .disabled(workout.busy)
                .accessibilityIdentifier("watchStopCleanup")
            }
            Spacer(minLength: 0)
            if !workout.message.isEmpty {
                Text(workout.message).font(.system(size: 9)).foregroundStyle(.secondary)
            }
            if !model.message.isEmpty {
                Text(model.message).font(.system(size: 10)).foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }.padding(.horizontal, 7).padding(.top, 24).padding(.bottom, 5)
        .frame(width: size.width, height: size.height)
        .accessibilityIdentifier("watchActions")
    }

}


/// A small native illustration keeps the approved friendly leaf motif crisp at Watch sizes.
private struct FriendlyLeaf: View {
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
