//
//  MainViewController.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import UIKit
import ComposableArchitecture
import Combine

final class MainViewController: UITabBarController, UITabBarControllerDelegate {
    private let store: Store<MainState, MainAction>
    private let viewStore: ViewStore<ViewState, MainAction>
    
    struct ViewState: Equatable {
        init(state: MainState) {
        }
    }
    
    init(store: Store<MainState, MainAction>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: ViewState.init))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStore.send(.onDidLoad)
        setupTabs()
    }
    
    private func setupTabs() {
        self.viewControllers = MainState.Tab.allCases.map { tab in
            switch tab {
            case .assets:
                let assetsViewController = AssetsViewController(
                    store: store.scope(
                        state: \.assets,
                        action: MainAction.assets
                    )
                )
                let assetsBarItem = UITabBarItem(
                    title: "Assets",
                    image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle"),
                    selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                )
                assetsViewController.tabBarItem = assetsBarItem
                return UINavigationController(rootViewController: assetsViewController)
            case .wallets:
                let walletsViewController = WalletsViewController(
                    store: store.scope(
                        state: \.wallets,
                        action: MainAction.wallets
                    )
                )
                let walletsBarItem = UITabBarItem(
                    title: "Wallets",
                    image: UIImage(systemName: "bag.circle"),
                    selectedImage: UIImage(systemName: "bag.circle.fill")
                )
                walletsViewController.tabBarItem = walletsBarItem
                return UINavigationController(rootViewController: walletsViewController)
            }
        }
    }
    
    // MARK: - UITabBarControllerDelegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabIndex = tabBar.items?.firstIndex(of: item), let tab = MainState.Tab(rawValue: tabIndex) else { return }
        viewStore.send(.onSelectTab(tab))
    }
}
