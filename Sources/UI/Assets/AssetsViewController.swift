//
//  AssetsViewController.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import UIKit
import ComposableArchitecture

class AssetsViewController: StateStoreTableViewController<AssetsState, AssetsAction> {
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private lazy var dataSource = makeDataSource()
    private lazy var filtersSegmentedControl = UISegmentedControl(
        items: AssetsState.Filter.allCases.map { $0.rawValue.capitalized }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureStateObservation()
        
        tableView.dataSource = dataSource
        registerCell()
    }
    
    func registerCell() {
        tableView.register(AssetCell.self, forCellReuseIdentifier: AssetCell.reuseIdentifier)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        guard newCollection.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        tableView.visibleCells.forEach {
            if let cell = $0 as? AssetCell {
                cell.updateImageForUserInterfaceStype()
            } else if let cell = $0 as? FiatWalletCell {
                cell.updateImageForUserInterfaceStype()
            } else {
                return
            }            
        }
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = AssetsState.Filter.allCases.map { $0.rawValue.capitalized }
        
        filtersSegmentedControl.selectedSegmentIndex = 0
        filtersSegmentedControl.addTarget(self, action: #selector(didSelectFilter(sender:)), for: .valueChanged)
        self.navigationItem.titleView = filtersSegmentedControl
    }
    
    @objc
    private func didSelectFilter(sender: UISegmentedControl) {
        viewStore.send(.onSelectFilter(AssetsState.Filter.allCases[sender.selectedSegmentIndex]))
        searchController.searchBar.selectedScopeButtonIndex = sender.selectedSegmentIndex
    }
    
    private func configureStateObservation() {
        viewStore.publisher.filteredAssets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] assets in
                var snapshot = NSDiffableDataSourceSnapshot<UserAsset.AssetType, UserAsset>()
                snapshot.appendSections(UserAsset.AssetType.allCases)
                
                snapshot.appendItems(assets.filter { $0.type == .basic }, toSection: .basic)
                snapshot.appendItems(assets.filter { $0.type == .commodity }, toSection: .commodity)
                snapshot.appendItems(assets.filter { $0.type == .fiat }, toSection: .fiat)

                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<UserAsset.AssetType, UserAsset> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, asset in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: AssetCell.reuseIdentifier,
                    for: indexPath
                ) as? AssetCell else { fatalError("Cell is not implemented") }

                cell.configure(asset: asset)
                return cell
            }
        )
    }
}

extension AssetsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, viewStore.searchText != searchText {
            viewStore.send(.onSearchTextChange(searchText))
        }
        
        let selectedFilter = AssetsState.Filter.allCases[searchController.searchBar.selectedScopeButtonIndex]
        if selectedFilter != viewStore.selectedFilter {
            viewStore.send(.onSelectFilter(selectedFilter))
            filtersSegmentedControl.selectedSegmentIndex = searchController.searchBar.selectedScopeButtonIndex
        }
    }
}
