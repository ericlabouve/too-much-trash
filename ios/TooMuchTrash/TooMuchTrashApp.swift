import SwiftUI

@main
struct TooMuchTrashApp: App {
    @UIApplicationDelegateAdaptor(UploadAppDelegate.self) private var uploadDelegate
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}
