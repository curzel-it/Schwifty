import SwiftUI

public enum AppInfo {
    public static var bundleIdentifier: String? {
        Bundle.main.bundleIdentifier
    }

    public static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
