import SwiftUI

extension View {
    @inlinable public func modifier<T: ViewModifier>(
        _ viewModifier: T,
        when condition: DeviceRequirement
    ) -> AnyView {
        if condition.isSatisfied {
            return AnyView(self.modifier(viewModifier))
        } else {
            return AnyView(self)
        }
    }
}

extension View {
    @inlinable public func onAppear(
        when condition: DeviceRequirement,
        _ action: @escaping () -> Void
    ) -> some View {
        self.onAppear {
            if condition.isSatisfied { action() }
        }
    }
}

extension View {
    public func font(_ font: Font?, when condition: DeviceRequirement) -> AnyView {
        if condition.isSatisfied {
            return AnyView(self.font(font))
        } else {
            return AnyView(self)
        }
    }
    
    @inlinable public func positioned(_ align: Positioning, when condition: DeviceRequirement) -> some View {
        if condition.isSatisfied {
            return AnyView(self.positioned(align))
        } else {
            return AnyView(self)
        }
    }
    
    @inlinable public func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        when condition: DeviceRequirement
    ) -> some View {
        if condition.isSatisfied {
            return AnyView(self.frame(width: width, height: height))
        } else {
            return AnyView(self)
        }
    }
    
    @inlinable public func frame(
        minWidth: CGFloat? = nil, maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil, maxHeight: CGFloat? = nil,
        when condition: DeviceRequirement
    ) -> some View {
        if condition.isSatisfied {
            return AnyView(
                self.frame(
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

extension DeviceRequirement {
    public var isSatisfied: Bool {
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
