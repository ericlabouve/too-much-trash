import SwiftUI

struct AppRootView: View {
    @StateObject private var account = AccountSession(automaticallyUseLocalCollector: true)
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if account.phase == .authorized {
                ContentView().environmentObject(account)
            } else {
                OnboardingView(account: account)
            }
        }
        .task {
            await account.bootstrap()
            while !Task.isCancelled {
                await account.probeAdmin()
                do { try await Task.sleep(for: .seconds(3)) } catch { break }
            }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                account.resume()
                Task {
                    if account.phase == .authorized { await account.continueLogin() }
                    await account.probeAdmin()
                }
            } else {
                account.suspend()
            }
        }
    }
}

struct OnboardingView: View {
    @ObservedObject var account: AccountSession
    @State private var showRegistration = false
    @State private var showConfiguration = false
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                Image(systemName: "leaf.fill").font(.system(size: 44)).foregroundStyle(.green)
                Text("Too Much Trash").font(.largeTitle.bold())
                Text("Collect pickup attempts. Help robots learn.").font(.title3)
                Text(account.message)
                    .foregroundStyle(.secondary)
                    .accessibilityIdentifier("accessMessage")
                if let deadline = account.retryNotBefore {
                    HStack { Text("Retry after:"); Text(deadline, style: .timer) }.font(.caption)
                }
                if account.busy { ProgressView("Checking access…") }
                Button("User login / Continue") { Task { await account.continueLogin() } }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("continueButton")
                Button("Register with invite") { showRegistration = true }
                    .buttonStyle(.bordered)
                    .accessibilityIdentifier("registerButton")
                if account.phase == .retry {
                    Button("Retry connection") { Task { await account.continueLogin() } }
                }
                if account.adminVisible {
                    Button("Admin login") {
                        Task {
                            if let url = await account.verifiedAdminURL() { openURL(url) }
                        }
                    }
                    .accessibilityIdentifier("adminLogin")
                }
                Spacer()
                Text("Invites come from your administrator.")
                    .font(.footnote).foregroundStyle(.secondary)
                if account.adminVisible {
                    Button("Server addresses") { showConfiguration = true }
                        .accessibilityIdentifier("serverAddresses")
                }
                if account.configuration?.simulatorLocal == true {
                    Text(account.adminVisible ? "Local Simulator · Admin view" : "Local Simulator · Collector view")
                        .font(.caption).foregroundStyle(.secondary)
                        .accessibilityIdentifier("collectorViewStatus")
                }
            }
            .padding(28)
            .frame(maxWidth: .infinity, alignment: .leading)
            .disabled(account.busy)
            .sheet(isPresented: $showRegistration) { RegistrationView(account: account) }
            .sheet(isPresented: $showConfiguration) { ServerConfigurationView(account: account) }
            .onChange(of: account.adminVisible) { _, visible in
                if !visible { showConfiguration = false }
            }
        }
    }
}

struct RegistrationView: View {
    @ObservedObject var account: AccountSession
    @Environment(\.dismiss) private var dismiss
    @State private var invite = ""
    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Register with invite") {
                    SecureField("Invite code", text: $invite)
                        .textInputAutocapitalization(.never).autocorrectionDisabled()
                        .accessibilityIdentifier("inviteCode")
                    TextField("Installation name (optional)", text: $name)
                        .accessibilityIdentifier("installationName")
                    Text("Enter the single-use invite your administrator shared with you.")
                        .font(.footnote)
                }
                Section {
                    Text(account.message).accessibilityIdentifier("registrationMessage")
                    Button("Register this iPhone") {
                        Task {
                            if await account.register(invite: invite, name: name) {
                                invite = ""
                                dismiss()
                            }
                        }
                    }
                    .disabled(account.busy || invite.isEmpty)
                }
            }
            .navigationTitle("Registration")
            .toolbar { Button("Close") { dismiss() }.disabled(account.busy) }
            .interactiveDismissDisabled(account.busy)
        }
    }
}

struct ServerConfigurationView: View {
    @ObservedObject var account: AccountSession
    @Environment(\.dismiss) private var dismiss
    @State private var publicURL = ""
    @State private var privateURL = ""
    @State private var simulatorLocal = false
    @State private var httpsPublicURL = ""
    @State private var httpsPrivateURL = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                #if DEBUG && targetEnvironment(simulator)
                Section("Simulator development") {
                    Toggle("Local backend (no Tailscale)", isOn: Binding(
                        get: { simulatorLocal }, set: { setLocalMode($0) }))
                        .accessibilityIdentifier("simulatorLocalBackend")
                    Button("Use localhost addresses") {
                        setLocalMode(true)
                    }
                    Text("Debug Simulator only. Local mode accepts HTTP localhost origins; authentication is still required.")
                        .font(.footnote)
                }
                #endif
                Section("Collector server") {
                    TextField("Public HTTPS origin", text: $publicURL, axis: .vertical)
                        .lineLimit(2...6)
                        .keyboardType(.URL).textInputAutocapitalization(.never).autocorrectionDisabled()
                        .accessibilityIdentifier("publicServerURL")
                    Text(simulatorLocal ? "Local collector on this Mac; no Tailscale required." : "Use the public address provided by your administrator.").font(.footnote)
                }
                Section("Private admin server (optional)") {
                    TextField("Private HTTPS origin", text: $privateURL, axis: .vertical)
                        .lineLimit(2...6)
                        .keyboardType(.URL).textInputAutocapitalization(.never).autocorrectionDisabled()
                        .accessibilityIdentifier("privateAdminURL")
                    Text(simulatorLocal ? "Use the isolated local development admin server on this Mac; no Tailscale required." : "A separate private address and authorized Tailscale connection are required for admin access.")
                        .font(.footnote)
                }
                if let errorMessage { Text(errorMessage).foregroundStyle(.red).accessibilityIdentifier("configurationError") }
                Button("Save addresses") {
                    do {
                        let configuration = try APIConfiguration(publicURL: publicURL, privateAdminURL: privateURL,
                                                                 simulatorLocal: simulatorLocal)
                        Task { await account.configure(configuration) }
                        dismiss()
                    } catch {
                        errorMessage = simulatorLocal
                            ? "Local Simulator mode requires separate HTTP localhost origins without paths, passwords, queries, or fragments."
                            : ClientError.configuration.message
                    }
                }
                .disabled(account.busy)
            }
            .navigationTitle("Server addresses")
            .toolbar { Button("Cancel") { dismiss() } }
            .onAppear {
                publicURL = account.configuration?.publicOrigin.absoluteString ?? ""
                privateURL = account.configuration?.privateAdminOrigin?.absoluteString ?? ""
                simulatorLocal = account.configuration?.simulatorLocal ?? false
                if !simulatorLocal {
                    httpsPublicURL = publicURL
                    httpsPrivateURL = privateURL
                } else {
                    if privateURL.isEmpty { privateURL = "http://localhost:18081" }
                    httpsPublicURL = account.adminNetworkConfiguration?.publicOrigin.absoluteString ?? ""
                    httpsPrivateURL = account.adminNetworkConfiguration?.privateAdminOrigin?.absoluteString ?? ""
                }
            }
        }
    }

    private func setLocalMode(_ enabled: Bool) {
        if enabled {
            if !simulatorLocal {
                httpsPublicURL = publicURL
                httpsPrivateURL = privateURL
            }
            publicURL = "http://localhost:18082"
            privateURL = "http://localhost:18081"
        } else {
            publicURL = httpsPublicURL
            privateURL = httpsPrivateURL
        }
        simulatorLocal = enabled
        errorMessage = nil
    }
}

struct UploadPanel: View {
    @ObservedObject var account: AccountSession
    @ObservedObject var queue: CaptureQueue

    var body: some View {
        let captures = account.currentCaptures
        let pending = captures.filter { $0.receipt == nil }.count
        let failed = captures.filter { $0.receipt?.status == "failed" }.count
        VStack(alignment: .leading, spacing: 10) {
            Text("\(pending) queued · \(captures.count - pending) sent").font(.caption.bold())
            if failed > 0 { Text("\(failed) processing failed; local videos retained.").font(.caption) }
            if queue.captures.count > captures.count {
                Text("Other installation's videos remain on this iPhone and will not be uploaded with this login.")
                    .font(.caption)
            }
            Text(queue.storageUnavailable ? "Upload queue unavailable. Local videos are retained." : account.uploadMessage)
                .font(.caption).fixedSize(horizontal: false, vertical: true)
            HStack {
                Button("Upload queued videos") { Task { await account.uploadPending() } }
                    .disabled(account.busy || pending == 0 || queue.storageUnavailable)
                Spacer()
                Button("Check status") { Task { await account.refreshUploadStatus() } }
                    .disabled(account.busy || captures.count == pending)
            }
            .font(.caption)
            if account.busy { ProgressView() }
        }
        .padding(16)
        .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: 16))
    }
}
