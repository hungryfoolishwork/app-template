import Foundation

extension Date {

    public var print: String {
        formatted(date: .complete, time: .omitted)
    }

    // Filename format

    public var filenameDateTime: String {
        Date.filenameDateTimeFormatter.string(from: self)
    }

    public var filenameDate: String {
        Date.filenameDateFormatter.string(from: self)
    }

    public static let filenameDateTimeFormatter = formatter("yyyy-MM-dd_HH-mm-ss")
    public static let filenameDateFormatter = formatter("yyyy-MM-dd")

    // RFC1123 format https://datatracker.ietf.org/doc/html/rfc822#section-5.1

    public var rfc1123: String {
        Date.rfc1123Formatter.string(from: self)
    }

    public static func fromRFC1123(_ string: String) -> Date? {
        rfc1123Formatter.date(from: string)
    }

    public static let rfc1123Formatter = formatter("EEE, dd MMM yyyy HH:mm:ss Z")

    static func formatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: -8 * 3600)
        formatter.dateFormat = format
        return formatter
    }
}
