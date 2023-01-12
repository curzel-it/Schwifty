import SwiftUI

public extension View {
    #if os(macOS)
        func measureAvailableSize(
            includeLiveResize: Bool = false,
            _ onSizeChanged: @escaping (CGSize) -> Void
        ) -> some View {
            onWindow { window in
                onSizeChanged(window.frame.size)
                if includeLiveResize {
                    NotificationCenter.default.addObserver(
                        forName: NSWindow.didResizeNotification, object: window, queue: .main
                    ) { _ in
                        onSizeChanged(window.frame.size)
                    }
                }
                NotificationCenter.default.addObserver(
                    forName: NSWindow.didEndLiveResizeNotification, object: window, queue: .main
                ) { _ in
                    onSizeChanged(window.frame.size)
                }
            }
        }
    #else
        func measureAvailableSize(_ onSizeChanged: @escaping (CGSize) -> Void) -> some View {
            ZStack {
                MeasurementView(onSizeChanged)
                self
            }
        }
    #endif
}

#if os(iOS)
    private struct MeasurementView: UIViewControllerRepresentable {
        typealias UIViewControllerType = MeasurementViewController
        let viewController: MeasurementViewController

        init(_ onSizeChanged: @escaping (CGSize) -> Void) {
            viewController = MeasurementViewController(onSizeChanged)
        }

        func makeUIViewController(context: Context) -> UIViewControllerType {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // ...
        }
    }

    private class MeasurementViewController: UIViewController {
        let onSizeChanged: (CGSize) -> Void

        init(_ onSizeChanged: @escaping (CGSize) -> Void) {
            self.onSizeChanged = onSizeChanged
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { abort() }

        override func viewWillTransition(to newSize: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: newSize, with: coordinator)
            Logger.log("Size changed to", newSize.description)
            onSizeChanged(newSize)
        }
    }
#endif
