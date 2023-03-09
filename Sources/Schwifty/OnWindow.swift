import SwiftUI

public extension View {
    func onWindow(_ foo: @escaping (SomeWindow) -> Void) -> some View {
        background(WindowGrabber(onWindow: foo))
    }
}

#if os(macOS)
public typealias SomeWindow = NSWindow
public typealias SomeView = NSView

private struct WindowGrabber: NSViewRepresentable {
    let onWindow: (SomeWindow) -> Void
    
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
public typealias SomeWindow = UIWindow
public typealias SomeView = UIView

private struct WindowGrabber: UIViewRepresentable {
    let onWindow: (SomeWindow) -> Void
    
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
