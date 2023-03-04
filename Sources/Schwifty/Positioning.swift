import SwiftUI

// MARK: - Positions

public enum Positioning {
    case leading
    case leadingTop
    case leadingMiddle
    case leadingBottom
    case top
    case middle
    case horizontalCenter
    case verticalCenter
    case bottom
    case trailing
    case trailingTop
    case trailingMiddle
    case trailingBottom
}

// MARK: - View Extension

public extension View {
    func positioned(_ align: Positioning) -> some View {
        modifier(PositioningMod(alignment: align))
    }
}

// MARK: - View Modifier

private struct PositioningMod: ViewModifier {
    let alignment: Positioning

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            if alignment.needsSpacerBefore {
                Spacer(minLength: 0)
            }
            VStack(spacing: 0) {
                if alignment.needsSpacerAbove {
                    Spacer(minLength: 0)
                }
                content
                if alignment.needsSpacerBelow {
                    Spacer(minLength: 0)
                }
            }
            if alignment.needsSpacerAfter {
                Spacer(minLength: 0)
            }
        }
    }
}

// MARK: - Utils

extension Positioning {
    var needsSpacerBefore: Bool {
        switch self {
        case .middle: return true
        case .horizontalCenter: return true
        case .trailing: return true
        case .trailingMiddle: return true
        case .trailingTop: return true
        case .trailingBottom: return true
        default: return false
        }
    }

    var needsSpacerAfter: Bool {
        switch self {
        case .middle: return true
        case .horizontalCenter: return true
        case .leading: return true
        case .leadingMiddle: return true
        case .leadingTop: return true
        case .leadingBottom: return true
        default: return false
        }
    }

    var needsSpacerAbove: Bool {
        switch self {
        case .bottom: return true
        case .verticalCenter: return true
        case .middle: return true
        case .leadingMiddle: return true
        case .leadingBottom: return true
        case .trailingMiddle: return true
        case .trailingBottom: return true
        default: return false
        }
    }

    var needsSpacerBelow: Bool {
        switch self {
        case .top: return true
        case .verticalCenter: return true
        case .middle: return true
        case .leadingTop: return true
        case .leadingMiddle: return true
        case .trailingTop: return true
        case .trailingMiddle: return true
        default: return false
        }
    }
}
