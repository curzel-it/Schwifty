import SwiftUI

#if os(macOS)
    public extension View {
        func onWindow(_ foo: @escaping (NSWindow) -> Void) -> some View {
            background(WindowGrabber(onWindow: foo))
        }
    }

    private struct WindowGrabber: NSViewRepresentable {
        let onWindow: (NSWindow) -> Void

        func makeNSView(context: Context) -> NSView {
            let view = NSView()
            view.layer?.backgroundColor = .clear
            DispatchQueue.main.async {
                if let window = view.window {
                    self.onWindow(window)
                }
            }
            return view
        }

        func updateNSView(_ view: NSView, context: Context) {}
    }
#else
    public extension View {
        func onWindow(_ foo: @escaping (UIWindow) -> Void) -> some View {
            background(WindowGrabber(onWindow: foo))
        }
    }

    private struct WindowGrabber: UIViewRepresentable {
        let onWindow: (UIWindow) -> Void

        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            view.backgroundColor = .clear
            DispatchQueue.main.async {
                if let window = view.window {
                    self.onWindow(window)
                }
            }
            return view
        }

        func updateUIView(_ view: UIView, context: Context) {}
    }
#endif
