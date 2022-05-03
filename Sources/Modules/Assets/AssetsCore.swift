//
//  AssetsCore.swift
//  CryptoMasterExampleiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import ComposableArchitecture

struct AssetsState: Equatable {
    enum Filter: String, CaseIterable {
        case all
        case basic
        case commodity
        case fiat
    }
    
    // We are using 3 different arrays to reduce filtering complexity

    var basicAssets: [UserAsset] = []
    var commodityAssets: [UserAsset] = []
    var fiatAssets: [UserAsset] = []
    
    var filteredAssets: [UserAsset] {
        let assets: [UserAsset]
        switch selectedFilter {
        case .all:
            assets = basicAssets + commodityAssets + fiatAssets
        case .basic:
            assets = basicAssets
        case .commodity:
            assets = commodityAssets
        case .fiat:
            assets = fiatAssets
        }
        
        return searchText.isEmpty ? assets : assets.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var searchText = ""
    var selectedFilter: Filter = .all
}

enum AssetsAction: Equatable {
    case onSearchTextChange(String)
    case onSelectFilter(AssetsState.Filter)
}

struct AssetsEnvironment {}

let assetsReducer = Reducer<AssetsState, AssetsAction, AssetsEnvironment>.combine(
    .init { state, action, _ in
        switch action {
        case .onSearchTextChange(let searchText):
            state.searchText = searchText
        case .onSelectFilter(let selectedFilter):
            state.selectedFilter = selectedFilter
        }
        
        return .none
    }
)
