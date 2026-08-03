import SwiftUI

extension Button where Label == SwiftUI.Label<Text, Image> {

    public static func done(_ title: String = "Done", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "checkmark", action: action)
    }

    public static func cancel(_ title: String = "Cancel", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "xmark", action: action)
    }

    public static func copy(_ title: String = "Copy", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "square.on.square", action: action)
    }

    public static func delete(_ title: String = "Delete", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "trash", action: action)
    }

    public static func share(_ title: String = "Share", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "square.and.arrow.up", action: action)
    }

    public static func settings(_ title: String = "Settings", _ action: @escaping () -> Void) -> Button {
        Button(title, systemImage: "gear", action: action)
    }
}
