import SwiftUI

extension View {
    public func measureScreenSize(to size: Binding<CGSize>) -> some View {
        ZStack {
            MeasurementView(size: size)
            self
        }
    }
}

private struct MeasurementView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MeasurementViewController
    let viewController: MeasurementViewController
    
    init(size: Binding<CGSize>) {
        viewController = MeasurementViewController(size: size)
    }
    
    func makeUIViewController(context: Context) -> MeasurementViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: MeasurementViewController, context: Context) {
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
        size = newSize
    }
}
