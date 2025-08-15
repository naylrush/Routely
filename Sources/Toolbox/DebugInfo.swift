#if DEBUG
import Foundation

public enum DebugInfo {
    public static var isInPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
#endif
