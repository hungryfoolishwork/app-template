import SwiftUI
import ProjectKit

@main
struct MainApp: App {
    @Environment(\.openWindow) var openWindow

    #if targetEnvironment(simulator)
    @State var state = AppState.preview
    #else
    @State var state = AppState()
    #endif

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AppRoot()
            }
        }
        .environment(state)
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button.settings {
                    openWindow(id: "settings")
                }
                .keyboardShortcut(",", modifiers: [.command])
            }
        }

        Window("Settings", id: "settings") {
            SettingsMain()
                .frame(minWidth: 512, idealWidth: 512, minHeight: 512, idealHeight: 512)
        }
        .environment(state)
        .defaultSize(width: 512, height: 512)
        .windowResizability(.contentSize)
        .keyboardShortcut(",", modifiers: [.command])
    }
}
