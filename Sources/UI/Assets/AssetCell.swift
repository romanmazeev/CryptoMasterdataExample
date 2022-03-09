//
//  AssetCell.swift
//  BitpandaTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import UIKit
import NukeUI

final class AssetCell: UITableViewCell {
    static let reuseIdentifier = "AssetCell"
    
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
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        

        addSubview(lazyImageView)
        addSubview(stackView)
        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            lazyImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lazyImageView.widthAnchor.constraint(equalToConstant: 50),
            lazyImageView.heightAnchor.constraint(equalToConstant: 50),
            lazyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: lazyImageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            priceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(asset: UserAsset) {
        lazyImageView.imageView.subviews.forEach { $0.removeFromSuperview() }
        darkModeLogoURL = asset.darkModeLogoURL
        logoURL = asset.logoURL
        updateImageForUserInterfaceStype()
        titleLabel.text = asset.name
        subtitleLabel.text = asset.symbol
        priceLabel.text = asset.priceText
        
        switch asset.option {
        case .wallet(let isDefault) where isDefault:
            backgroundColor = .systemYellow.withAlphaComponent(0.1)
        default:
            backgroundColor = .systemBackground
        }
    }
    
    func updateImageForUserInterfaceStype() {
        lazyImageView.reset()
        lazyImageView.source = traitCollection.userInterfaceStyle == .dark ? darkModeLogoURL : logoURL
    }
}
