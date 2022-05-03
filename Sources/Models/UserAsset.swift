//
//  Asset.swift
//  CryptoMasterExampleTest
//
//  Created by Roman Mazeev on 09/03/22.
//

import Foundation

struct UserAsset {
    enum AssetOption {
        case asset
        case wallet(isDefault: Bool)
    }

    enum AssetType: String, CaseIterable {
        case basic
        case commodity
        case fiat
    }
    
    let id = UUID()
    let type: AssetType
    let option: AssetOption
    let name: String
    let symbol: String
    let priceText: String

    let logoURL: String
    let darkModeLogoURL: String
}

extension UserAsset: Equatable {
    static func == (lhs: UserAsset, rhs: UserAsset) -> Bool {
        lhs.id == rhs.id
    }
}

extension UserAsset: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
