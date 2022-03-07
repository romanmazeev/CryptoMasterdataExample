//
//  AssetsViewController.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import UIKit
import ComposableArchitecture
import Combine

final class AssetsViewController: UITableViewController {
    private let store: Store<AssetsState, AssetsAction>
    private let viewStore: ViewStore<ViewState, AssetsAction>
    
    struct ViewState: Equatable {
        init(state: AssetsState) {
        }
    }
    
    init(store: Store<AssetsState, AssetsAction>) {
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
        title = "Assets"
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
