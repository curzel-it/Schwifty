import SwiftUI

public struct Screen {
    public static var main: Screen {
#if os(macOS)
        let frame = NSScreen.main?.frame ?? .zero
        return Screen(bounds: CGRect(origin: .zero, size: frame.size))
#else
        return Screen(bounds: UIScreen.main.bounds)
#endif
    }
    
    let bounds: CGRect
}

extension View {
    public func measureScreenSize(to size: Binding<CGSize>) -> some View {
        ZStack {
            MeasurementView(size: size)
            self
        }
    }
}

#if os(macOS)
private struct MeasurementView: NSViewControllerRepresentable {
    typealias NSViewControllerType = MeasurementViewController
    let viewController: MeasurementViewController
    
    init(size: Binding<CGSize>) {
        viewController = MeasurementViewController(size: size)
    }
    
    func makeNSViewController(context: Context) -> NSViewControllerType {
        viewController
    }
    
    func updateNSViewController(_ uiViewController: NSViewControllerType, context: Context) {
        // ...
    }
}

private class MeasurementViewController: NSViewController {
    @Binding var size: CGSize
    
    init(size: Binding<CGSize>) {
        self._size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { abort() }
    
    
    override func viewWillTransition(to newSize: NSSize) {
        super.viewWillTransition(to: newSize)
        size = newSize
    }
}
#else
private struct MeasurementView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MeasurementViewController
    let viewController: MeasurementViewController
    
    init(size: Binding<CGSize>) {
        viewController = MeasurementViewController(size: size)
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // ...
    }
}

private class MeasurementViewController: UIViewController {
    @Binding var size: CGSize
    
    init(size: Binding<CGSize>) {
        self._size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { abort() }
    
    override func viewWillTransition(to newSize: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: newSize, with: coordinator)
        size = newSize
    }
}
#endif
