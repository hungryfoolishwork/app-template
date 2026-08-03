import Foundation
import ProjectCore

@MainActor
@Observable
public final class AppState {

    public var router = Router()

    public init() {}
}

extension AppState {

    public static var preview: AppState {
        .init()
    }
}
