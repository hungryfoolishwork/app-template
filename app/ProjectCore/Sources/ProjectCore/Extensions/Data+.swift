import Foundation

extension Data {

    public func write(to url: URL, options: Data.WritingOptions = [], withIntermediateDirectories: Bool) throws {
        if withIntermediateDirectories {
            try FileManager.default.createDirectory(
                at: url.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
        }
        try write(to: url, options: options)
    }
}
