import SwiftUI

struct AppRootView: View {
    @StateObject private var account = AccountSession()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if account.phase == .authorized {
                ContentView().environmentObject(account)
            } else {
                OnboardingView(account: account)
            }
        }
        .task { await account.bootstrap() }
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
                Text("Invites come from your administrator. Collectors do not need Tailscale.")
                    .font(.footnote).foregroundStyle(.secondary)
                Button("Server addresses") { showConfiguration = true }
                    .accessibilityIdentifier("serverAddresses")
            }
            .padding(28)
            .frame(maxWidth: .infinity, alignment: .leading)
            .disabled(account.busy)
            .sheet(isPresented: $showRegistration) { RegistrationView(account: account) }
            .sheet(isPresented: $showConfiguration) { ServerConfigurationView(account: account) }
            .task(id: account.configuration) {
                // Refresh private reachability while Home is visible, and again at tap time.
                while !Task.isCancelled {
                    await account.probeAdmin()
                    do { try await Task.sleep(for: .seconds(15)) } catch { break }
                }
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
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section("Collector server") {
                    TextField("Public HTTPS origin", text: $publicURL)
                        .keyboardType(.URL).textInputAutocapitalization(.never).autocorrectionDisabled()
                        .accessibilityIdentifier("publicServerURL")
                    Text("Use the public address provided by your administrator.").font(.footnote)
                }
                Section("Private admin server (optional)") {
                    TextField("Private HTTPS origin", text: $privateURL)
                        .keyboardType(.URL).textInputAutocapitalization(.never).autocorrectionDisabled()
                        .accessibilityIdentifier("privateAdminURL")
                    Text("A separate private address and authorized Tailscale connection are required for admin access.")
                        .font(.footnote)
                }
                if let errorMessage { Text(errorMessage).foregroundStyle(.red).accessibilityIdentifier("configurationError") }
                Button("Save addresses") {
                    do {
                        let configuration = try APIConfiguration(publicURL: publicURL, privateAdminURL: privateURL)
                        Task { await account.configure(configuration) }
                        dismiss()
                    } catch { errorMessage = ClientError.configuration.message }
                }
                .disabled(account.busy)
            }
            .navigationTitle("Server addresses")
            .toolbar { Button("Cancel") { dismiss() } }
            .onAppear {
                publicURL = account.configuration?.publicOrigin.absoluteString ?? ""
                privateURL = account.configuration?.privateAdminOrigin?.absoluteString ?? ""
            }
        }
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
