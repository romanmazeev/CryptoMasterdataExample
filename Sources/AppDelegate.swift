import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController(
            store: .init(
                initialState: .init(),
                reducer: mainReducer,
                environment: .init(mainQueue: .main, repository: .live)
            )
        )
        window?.makeKeyAndVisible()

        return true
    }

}
