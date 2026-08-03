import SwiftUI

extension Color {

    static let highlight = Color.primary.opacity(0.1)

    public static func hex(_ hex: UInt, alpha: Double = 1.0) -> Color {
        Color(cgColor: .hex(hex, alpha: alpha))
    }

    public static func hex(_ hex: String, alpha: Double = 1.0) -> Color {
        Color(cgColor: .hex(hex, alpha: alpha))
    }
}

extension CGColor {

    public static func hex(_ hex: UInt, alpha: Double = 1.0) -> CGColor {
        CGColor(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: CGFloat(alpha)
        )
    }

    public static func hex(_ string: String, alpha: Double = 1.0) -> CGColor {
        var str = string
        if str.hasPrefix("#") { str.removeFirst() }
        var v: UInt64 = 0
        Scanner(string: str).scanHexInt64(&v)
        return hex(UInt(v), alpha: alpha)
    }
}
