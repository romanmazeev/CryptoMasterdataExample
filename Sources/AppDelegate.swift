import UIKit
import NukeUI
import Nuke
import SVGKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        setupNuke()
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController(
            store: .init(
                initialState: .init(),
                reducer: mainReducer,
                environment: .init(mainQueue: .main, userRepository: .live)
            )
        )
        window?.makeKeyAndVisible()

        return true
    }
    
    private func setupNuke() {
        ImageDecoderRegistry.shared.register { context in
            let isSVG = context.urlResponse?.url?.absoluteString.hasSuffix(".svg") ?? false
            return isSVG ? ImageDecoders.Empty(imageType: .svg) : nil
        }
        
        ImageView.registerContentView {
            guard $0.type == .svg, let data = $0.data else { return nil }
            
            // FIXME: Bitcoin image failed to parse firts time
            if let image = SVGKImage(data: data) {
                return SVGKFastImageView(svgkImage: image)
            } else {
                return SVGKFastImageView(svgkImage: .init(data: data))
            }
        }
    }
}
