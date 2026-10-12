import SwiftUI

struct AppRootView: View {
    @StateObject private var account = AccountSession(automaticallyUseLocalCollector: AppRootView.useLocalFallback, automaticUploads: true)
    @Environment(\.scenePhase) private var scenePhase

    private static var useLocalFallback: Bool {
        #if DEBUG && targetEnvironment(simulator)
        return !UserDefaults.standard.bool(forKey: "disableLocalFallback")
        #else
        return true
        #endif
    }

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
                account.syncTick()
                do { try await Task.sleep(for: .seconds(3)) } catch { break }
            }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                account.resume()
                Task {
                    if account.phase == .authorized { await account.continueLogin() }
                    else { await account.bootstrap() }
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
    @State private var showConfiguration = false

    var body: some View {
        NavigationStack {
            Group {
                if account.busy {
                    ProgressView(account.isEndingSession ? "Ending session…" : "Checking access…")
                } else if account.endCleanupPending {
                    VStack(spacing: 20) {
                        Text("Finish ending session").font(.title2)
                        Text(account.message).multilineTextAlignment(.center)
                        Button("Retry End Session") { Task { _ = await account.endSession() } }
                            .buttonStyle(.borderedProminent)
                    }.padding(28)
                } else if account.hasSavedCredential && account.phase != .needsInvite {
                    VStack(spacing: 20) {
                        Text("Can’t connect").font(.title2)
                        Text(account.message).multilineTextAlignment(.center)
                        Button("Retry connection") { Task { await account.continueLogin() } }
                            .buttonStyle(.borderedProminent).accessibilityIdentifier("retryConnection")
                    }.padding(28)
                } else {
                    RegistrationView(account: account)
                }
            }
            .navigationTitle("Too Much Trash")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .topBarTrailing) {
                if account.adminVisible { AdminActions(account: account, showConfiguration: $showConfiguration) }
            } }
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
    @State private var words = InviteWordEntry()
    @State private var attemptedRegistration = false
    @FocusState private var focusedWord: InviteWordEntry.Field?
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
            Form {
                Section("Register with invite") {
                    if dynamicTypeSize.isAccessibilitySize {
                        VStack(spacing: 12) { wordField(.first); wordField(.second) }
                    } else {
                        HStack(spacing: 12) { wordField(.first); wordField(.second) }
                    }
                    Text("Enter the two word invite phrase above")
                        .font(.footnote).foregroundStyle(.secondary)
                }
                Section {
                    if attemptedRegistration {
                        Text(account.message).accessibilityIdentifier("registrationMessage")
                    }
                    if let deadline = account.retryNotBefore {
                        HStack { Text("Retry after:"); Text(deadline, style: .timer) }.font(.caption)
                    }
                    Button("Register") {
                        focusedWord = nil
                        Task {
                            if await account.register(invite: words.code, name: "") {
                                words = InviteWordEntry()
                                dismiss()
                            } else { attemptedRegistration = true }
                        }
                    }
                    .disabled(account.busy || !words.isComplete)
                    .accessibilityIdentifier("submitRegistration")
                }
            }
    }

    private func wordField(_ field: InviteWordEntry.Field) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(field == .first ? "Word 1" : "Word 2")
                .font(.caption).foregroundStyle(.secondary)
            TextField(field == .first ? "First word" : "Second word", text: Binding(
                get: { field == .first ? words.first : words.second },
                set: { value in
                    if words.update(value, field: field) { focusedWord = nil }
                    else if field == .first, value.last?.isWhitespace == true,
                            value.split(whereSeparator: { $0.isWhitespace }).count == 1 {
                        words.first = value.trimmingCharacters(in: .whitespacesAndNewlines)
                        focusedWord = .second
                    }
                }))
                .textInputAutocapitalization(.never).autocorrectionDisabled()
                .focused($focusedWord, equals: field)
                .submitLabel(field == .first ? .next : .done)
                .onSubmit { focusedWord = field == .first ? .second : nil }
                .padding(12)
                .background(.background, in: RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(focusedWord == field ? Color.accentColor : Color.secondary.opacity(0.3), lineWidth: 1.5))
                .accessibilityLabel(field == .first ? "Invite word 1" : "Invite word 2")
                .accessibilityIdentifier(field == .first ? "inviteWord1" : "inviteWord2")
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
                .disabled(account.busy || account.isUploading || account.endCleanupPending)
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
