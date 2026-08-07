import Foundation

extension URL {
    public static let home = URL.documentsDirectory

    public var exists: Bool {
        guard isFileURL else { return false }
        return FileManager.default.fileExists(atPath: path(percentEncoded: false))
    }

    public func relativePath(base: URL) -> String {
        String(path().trimmingPrefix(base.path()).trimmingPrefix("/"))
    }

    public var params: [String: String] {
        get {
            guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
                return [:]
            }
            return components.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
        }
        set {
            var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
            components?.queryItems = newValue.map { URLQueryItem(name: $0.key, value: $0.value.isEmpty ? nil : $0.value) }
            self = components?.url ?? self
        }
    }
}
