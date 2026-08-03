import SwiftUI
import ProjectKit

@main
struct MainApp: App {

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
    }
}
