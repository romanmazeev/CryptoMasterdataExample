//
//  FiatWalletCell.swift
//  CryptoMasterExampleTest
//
//  Created by Roman Mazeev on 09/03/22.
//

import UIKit
import NukeUI

final class FiatWalletCell: UITableViewCell {
    static let reuseIdentifier = "FiatWalletCell"
    
    private var darkModeLogoURL = ""
    private var logoURL = ""
    
    private lazy var lazyImageView: LazyImageView = {
        let view = LazyImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lazyImageView.reset()
    }

    private func setupUI() {
        selectionStyle = .none
        lazyImageView.placeholderView = UIActivityIndicatorView()
        lazyImageView.failureImage = UIImage(systemName: "questionmark.circle.fill")
        lazyImageView.tintColor = .systemGray

        addSubview(lazyImageView)
        addSubview(priceLabel)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            lazyImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lazyImageView.widthAnchor.constraint(equalToConstant: 30),
            lazyImageView.heightAnchor.constraint(equalToConstant: 30),
            lazyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: lazyImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            priceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(asset: UserAsset) {
        lazyImageView.imageView.subviews.forEach { $0.removeFromSuperview() }
        darkModeLogoURL = asset.darkModeLogoURL
        logoURL = asset.logoURL
        updateImageForUserInterfaceStype()
        titleLabel.text = "\(asset.name) | \(asset.symbol)"
        priceLabel.text = asset.priceText
    }
    
    func updateImageForUserInterfaceStype() {
        lazyImageView.reset()
        lazyImageView.source = traitCollection.userInterfaceStyle == .dark ? darkModeLogoURL : logoURL
    }
}
