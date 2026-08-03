import Foundation
import ProjectCore

@Observable
public final class AppState {

    public init() {}
}

extension AppState {

    public static var preview: AppState {
        .init()
    }
}
