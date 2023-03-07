import SwiftUI

public enum DeviceRequirement {
    case always
    case carPlay
    case catalyst
    case macOS
    case iOS
    case iPad
    case iPhone
    case appleTv
    case portrait
    case landscape
}

public extension DeviceRequirement {
    static func allSatisfied(_ requirements: DeviceRequirement...) -> Bool {
        requirements.allSatisfy { $0.isSatisfied }
    }
    
    static func allSatisfied(_ requirements: [DeviceRequirement]) -> Bool {
        requirements.allSatisfy { $0.isSatisfied }
    }
    
    var isSatisfied: Bool {
#if os(macOS)
        switch self {
        case .always: return true
        case .macOS: return true
        case .landscape: return true
        default: return false
        }
#else
        let idiom = UIDevice.current.userInterfaceIdiom
        let orientation = UIDevice.current.orientation
        switch self {
        case .always: return true
        case .carPlay: return idiom == .carPlay
        case .catalyst: return idiom == .mac
        case .iOS: return true
        case .iPad: return idiom == .pad
        case .iPhone: return idiom == .phone
        case .macOS: return false
        case .appleTv: return idiom == .tv
        case .landscape: return orientation == .landscapeLeft || orientation == .landscapeRight
        case .portrait: return orientation == .portrait || orientation == .portraitUpsideDown
        }
#endif
    }
}

public extension View {
    @inlinable func modifier<T: ViewModifier>(
        when requirements: DeviceRequirement...,
        apply viewModifier: T
    ) -> AnyView {
        if DeviceRequirement.allSatisfied(requirements) {
            return AnyView(modifier(viewModifier))
        } else {
            return AnyView(self)
        }
    }
}

public extension View {
    func font(when requirements: DeviceRequirement..., font: Font?) -> some View {
        self.font(
            DeviceRequirement.allSatisfied(requirements) ? font : nil
        )
    }
    
    @inlinable func positioned(when requirements: DeviceRequirement..., align: Positioning) -> some View {
        let doesApply = DeviceRequirement.allSatisfied(requirements)
        return positioned(doesApply ? align : .none)
    }
    
    @inlinable func frame(
        when requirements: DeviceRequirement...,
        width: CGFloat? = nil,
        minWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        height: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) -> some View {
        let doesApply = DeviceRequirement.allSatisfied(requirements)
        return self
            .frame(width: doesApply ? width : nil)
            .frame(minWidth: doesApply ? minWidth : nil)
            .frame(maxWidth: doesApply ? maxWidth : nil)
            .frame(height: doesApply ? height : nil)
            .frame(minHeight: doesApply ? minHeight : nil)
            .frame(maxHeight: doesApply ? maxHeight : nil)
    }
}
