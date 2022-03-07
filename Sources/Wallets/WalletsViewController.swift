//
//  WalletsViewController.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import UIKit
import ComposableArchitecture
import Combine

final class WalletsViewController: UITableViewController {
    private let store: Store<WalletsState, WalletsAction>
    private let viewStore: ViewStore<ViewState, WalletsAction>
    
    struct ViewState: Equatable {
        init(state: WalletsState) {
        }
    }
    
    init(store: Store<WalletsState, WalletsAction>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: ViewState.init))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Wallets"
        view.backgroundColor = .systemBackground
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .init()
    }
}
