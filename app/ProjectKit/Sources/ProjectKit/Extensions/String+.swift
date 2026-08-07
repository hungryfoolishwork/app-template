import Foundation

extension String {

    public static var uuid: String {
        UUID().uuidString
    }

    public static var uuidShort: String {
        UUID().uuidString.prefix(7).lowercased()
    }

    public func trimmingWhitespace() -> String? {
        let out = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return out.isEmpty ? nil : out
    }

    public func trimmingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }

    public var `extension`: String? {
        split(separator: ".").last.map(String.init)
    }
}
