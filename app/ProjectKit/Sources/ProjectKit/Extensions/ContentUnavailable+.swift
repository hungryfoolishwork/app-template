import SwiftUI

extension ContentUnavailableView where Label == SwiftUI.Label<Text, Image>, Description == Text, Actions == EmptyView {

    public static var noContent: some View {
        ContentUnavailableView {
            Label("No content", systemImage: "doc.plaintext")
        } description: {
            Text("Content not available")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
