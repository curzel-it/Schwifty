#if os(macOS)
import AppKit
public typealias ViewType = NSView
#else
import UIKit
public typealias ViewType = UIView
#endif

extension ViewType {
    public func constrainToFillParent() {
        guard let parent = superview else { return }
        frame = parent.bounds
        NSLayoutConstraint.activate([
            .anchor(self, to: parent, on: .top),
            .anchor(self, to: parent, on: .bottom),
            .anchor(self, to: parent, on: .leading),
            .anchor(self, to: parent, on: .trailing)
        ])
    }
    
    public func constrain(_ attribute: NSLayoutConstraint.Attribute, to value: CGFloat) {
        NSLayoutConstraint(
            item: self,
            attribute: attribute, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute,
            multiplier: 1,
            constant: value
        ).isActive = true
    }
    
    public func constrainToCenterInParent() {
        guard let parent = superview else { return }
        NSLayoutConstraint.activate([
            .anchor(self, to: parent, on: .centerX),
            .anchor(self, to: parent, on: .centerY)
        ])
    }
}

extension NSLayoutConstraint {    
    public static func anchor(
        _ view: ViewType,
        to other: ViewType,
        on side: NSLayoutConstraint.Attribute
    ) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view, attribute: side,
            relatedBy: .equal,
            toItem: other, attribute: side,
            multiplier: 1, constant: 0
        )
    }
}
