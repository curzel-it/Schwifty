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

public struct DeviceRequirements {
    let condition: DeviceRequirementsCondition
    let requirements: [DeviceRequirement]
    
    public static func `is`(_ requirement: DeviceRequirement) -> DeviceRequirements {
        .init(condition: .all, requirements: [requirement])
    }
    
    public static func all(_ requirements: DeviceRequirement...) -> DeviceRequirements {
        .init(condition: .all, requirements: requirements)
    }
    
    public static func any(_ requirements: DeviceRequirement...) -> DeviceRequirements {
        .init(condition: .any, requirements: requirements)
    }
    
    init(condition: DeviceRequirementsCondition, requirements: [DeviceRequirement]) {
        self.condition = condition
        self.requirements = requirements
    }
    
    func areSatisfied() -> Bool {
        switch condition {
        case .all: return requirements.allSatisfy { $0.isSatisfied }
        case .any: return requirements.contains { $0.isSatisfied }
        }
    }
}

enum DeviceRequirementsCondition {
    case any
    case all
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
    func modifier<T: ViewModifier>(
        when requirements: DeviceRequirements,
        apply viewModifier: T
    ) -> AnyView {
        if requirements.areSatisfied() {
            return AnyView(modifier(viewModifier))
        } else {
            return AnyView(self)
        }
    }
}

public extension View {
    func font(when requirements: DeviceRequirements, font: Font?) -> some View {
        self.font(
            requirements.areSatisfied() ? font : nil
        )
    }
    
    func padding(when requirements: DeviceRequirements, _ edges: Edge.Set, _ length: CGFloat? = nil) -> some View {
        let doesApply = requirements.areSatisfied()
        return padding(
            doesApply ? edges : [],
            doesApply ? length : 0
        )
    }
    
    func positioned(when requirements: DeviceRequirements, align: Positioning) -> some View {
        let doesApply = requirements.areSatisfied()
        return positioned(doesApply ? align : .none)
    }
    
    func frame(
        when requirements: DeviceRequirements,
        width: CGFloat? = nil,
        minWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        height: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) -> some View {
        let doesApply = requirements.areSatisfied()
        return self
            .frame(width: doesApply ? width : nil)
            .frame(minWidth: doesApply ? minWidth : nil)
            .frame(maxWidth: doesApply ? maxWidth : nil)
            .frame(height: doesApply ? height : nil)
            .frame(minHeight: doesApply ? minHeight : nil)
            .frame(maxHeight: doesApply ? maxHeight : nil)
    }
}
