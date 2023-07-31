import Foundation
final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            if #available(iOS 16.0, *) {
                try? await Task.sleep(for: Duration.seconds(1))
            } else {
                // Fallback on earlier versions
            }

            self.state = .finished
        }
    }
}
