//
//  WalletAssetsViewController.swift
//  BitpandaTest
//
//  Created by Roman Mazeev on 09/03/22.
//

import UIKit

class WalletAssetsViewController: AssetsViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let assetType = UserAsset.AssetType.allCases[section]
        
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .footnote)
        label.text = assetType.rawValue.capitalized
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
        ])
    
        return view
    }
    
    override func registerCell() {
        super.registerCell()
        tableView.register(FiatWalletCell.self, forCellReuseIdentifier: FiatWalletCell.reuseIdentifier)
    }
    
    override func makeDataSource() -> UITableViewDiffableDataSource<UserAsset.AssetType, UserAsset> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, asset in
                switch asset.type {
                case .fiat:
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: FiatWalletCell.reuseIdentifier,
                        for: indexPath
                    ) as? FiatWalletCell else { fatalError("Cell is not implemented") }
                    cell.configure(asset: asset)
                    return cell
                default:
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: AssetCell.reuseIdentifier,
                        for: indexPath
                    ) as? AssetCell else { fatalError("Cell is not implemented") }
                    cell.configure(asset: asset)
                    return cell
                }
            }
        )
    }
}
