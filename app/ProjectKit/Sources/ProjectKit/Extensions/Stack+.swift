import SwiftUI

extension VStack {

    public static func leading(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: spacing, content: content)
    }

    public static func center(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .center, spacing: spacing, content: content)
    }

    public static func trailing(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .trailing, spacing: spacing, content: content)
    }
}

extension LazyVStack {

    public static func leading(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyVStack(alignment: .leading, spacing: spacing, content: content)
    }

    public static func center(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyVStack(alignment: .center, spacing: spacing, content: content)
    }

    public static func trailing(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyVStack(alignment: .trailing, spacing: spacing, content: content)
    }
}

extension HStack {

    public static func top(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .top, spacing: spacing, content: content)
    }

    public static func bottom(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .bottom, spacing: spacing, content: content)
    }

    public static func firstTextBaseline(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: spacing, content: content)
    }

    public static func lastTextBaseline(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .lastTextBaseline, spacing: spacing, content: content)
    }
}

extension LazyHStack {

    public static func top(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyHStack(alignment: .top, spacing: spacing, content: content)
    }

    public static func bottom(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyHStack(alignment: .bottom, spacing: spacing, content: content)
    }

    public static func firstTextBaseline(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyHStack(alignment: .firstTextBaseline, spacing: spacing, content: content)
    }

    public static func lastTextBaseline(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) -> some View {
        LazyHStack(alignment: .lastTextBaseline, spacing: spacing, content: content)
    }
}
