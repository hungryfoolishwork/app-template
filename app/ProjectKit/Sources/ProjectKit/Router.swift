import SwiftUI
import ProjectCore

public enum Route: Identifiable, Hashable, Codable {
    case settings

    public var path: String {
        switch self {
        case .settings: "settings"
        }
    }

    public var id: String { path }
}

@MainActor
@Observable
public final class Router {

    public var path: [Route] = [] {
        didSet { scheduleSave() }
    }

    public var modal: Route? = nil

    public init() {}

    public func push(_ route: Route) {
        path.append(route)
    }

    public func present(_ route: Route) {
        modal = route
    }

    public func dismiss() {
        modal = nil
    }

    public func reset() {
        path.removeAll()
        modal = nil
    }

    public func handle(_ url: URL) {
        guard let host = url.host() else { return }
        switch "\(host)\(url.path())" {
        case "settings":
            present(.settings)
        default:
            break
        }
    }

    // MARK: Persistence

    public func restore(resolve: (String) -> Bool) {
        guard
            let data = UserDefaults.standard.data(forKey: Self.snapshotKey),
            let snapshot = try? JSONDecoder().decode(RouterSnapshot.self, from: data)
        else { return }
        print("Router.restore not implemented: \(snapshot)")
    }

    public func persist() {
        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        UserDefaults.standard.set(data, forKey: Self.snapshotKey)
    }

    private func scheduleSave() {
        saveDebouncer.run { [weak self] in
            self?.persist()
        }
    }
    
    private static let snapshotKey = "router.snapshot"
    private let saveDebouncer = Debouncer(delay: .milliseconds(500))

    private var snapshot: RouterSnapshot {
        RouterSnapshot(path: path)
    }
}

public struct RouterSnapshot: Codable {
    public var path: [Route]
}
