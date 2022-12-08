import SwiftUI

public extension View {
    @inlinable func modifier<T: ViewModifier>(
        _ viewModifier: T,
        when condition: DeviceRequirement
    ) -> AnyView {
        if condition.isSatisfied {
            return AnyView(modifier(viewModifier))
        } else {
            return AnyView(self)
        }
    }
}

public extension View {
    @inlinable func onAppear(
        when condition: DeviceRequirement,
        _ action: @escaping () -> Void
    ) -> some View {
        onAppear {
            if condition.isSatisfied { action() }
        }
    }
}

public extension View {
    func font(_ font: Font?, when condition: DeviceRequirement) -> AnyView {
        if condition.isSatisfied {
            return AnyView(self.font(font))
        } else {
            return AnyView(self)
        }
    }

    @inlinable func positioned(_ align: Positioning, when condition: DeviceRequirement) -> some View {
        if condition.isSatisfied {
            return AnyView(positioned(align))
        } else {
            return AnyView(self)
        }
    }

    @inlinable func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        when condition: DeviceRequirement
    ) -> some View {
        if condition.isSatisfied {
            return AnyView(frame(width: width, height: height))
        } else {
            return AnyView(self)
        }
    }

    @inlinable func frame(
        minWidth: CGFloat? = nil, maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil, maxHeight: CGFloat? = nil,
        when condition: DeviceRequirement
    ) -> some View {
        if condition.isSatisfied {
            return AnyView(
                frame(
                    minWidth: minWidth, maxWidth: maxWidth,
                    minHeight: minHeight, maxHeight: maxHeight
                )
            )
        } else {
            return AnyView(self)
        }
    }
}

public enum DeviceRequirement {
    case always
    case carPlay
    case catalyst
    case macOS
    case iOS
    case iPad
    case iPhone
    case appleTv
}

public extension DeviceRequirement {
    var isSatisfied: Bool {
        #if os(macOS)
            if self == .macOS || self == .always { return true }
            return false
        #else
            let idiom = UIDevice.current.userInterfaceIdiom
            switch self {
            case .always: return true
            case .carPlay: return idiom == .carPlay
            case .catalyst: return idiom == .mac
            case .iOS: return true
            case .iPad: return idiom == .pad
            case .iPhone: return idiom == .phone
            case .macOS: return false
            case .appleTv: return idiom == .tv
            }
        #endif
    }
}
