//
//  MainCore.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 09/03/22.
//

import ComposableArchitecture

struct MainState: Equatable {
    enum Tab: Int, CaseIterable, Equatable {
        case assets
        case wallets
    }
    
    var assetState = AssetsState()
    var walletAssetsState = AssetsState()
    
    var selectedTab: Tab = .assets
}

enum MainAction {
    case onDidLoad
    case onSelectTab(MainState.Tab)
    
    case assets(AssetsAction)
    case wallets(AssetsAction)
    
    case onReceiveUser(Result<User, Error>)
}

struct MainEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let userRepository: UserRepository
}

let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
    assetsReducer
           .pullback(
               state: \.assetState,
               action: /MainAction.assets,
               environment: { _ in .init() }
           ),
    assetsReducer
           .pullback(
               state: \.walletAssetsState,
               action: /MainAction.wallets,
               environment: { _ in .init() }
           ),
    .init { state, action, environment in
        switch action {
        case .onDidLoad:
            return environment.userRepository.getUser()
                .receive(on: environment.mainQueue)
                .catchToEffect(MainAction.onReceiveUser)
        case .onReceiveUser(let result):
            switch result {
            case .success(let user):
                guard let symbolCharacter = user.holdings.attributes.fiats.first(
                    where: { $0.attributes.symbol == "EUR" }
                )?.attributes.symbolCharacter else {
                    return .none
                }
                
                // MARK: Assets

                state.assetState.basicAssets = user.holdings.attributes.cryptocoins.map {
                    .init(
                        type: .basic,
                        option: .asset,
                        name: $0.attributes.name,
                        symbol: $0.attributes.symbol,
                        priceText: Double($0.attributes.avgPrice)?.toCurrencyString(
                            maximumFractionDigits: $0.attributes.precisionForFiatPrice,
                            symbolCharacter: symbolCharacter
                        ) ?? "",
                        logoURL: $0.attributes.logo,
                        darkModeLogoURL: $0.attributes.logoDark
                    )
                }
                
                state.assetState.commodityAssets = user.holdings.attributes.commodities.map {
                    .init(
                        type: .commodity,
                        option: .asset,
                        name: $0.attributes.name,
                        symbol: $0.attributes.symbol,
                        priceText: Double($0.attributes.avgPrice)?.toCurrencyString(
                            maximumFractionDigits: $0.attributes.precisionForFiatPrice,
                            symbolCharacter: symbolCharacter
                        ) ?? "",
                        logoURL: $0.attributes.logo,
                        darkModeLogoURL: $0.attributes.logoDark
                    )
                }
                
                state.assetState.fiatAssets = user.holdings.attributes.fiats
                    .filter { fiat in
                        user.holdings.attributes.fiatWallets
                            .map { $0.attributes.fiatId }
                            .contains(fiat.id)
                    }
                    .map {
                        .init(
                            type: .fiat,
                            option: .asset,
                            name: $0.attributes.name,
                            symbol: $0.attributes.symbol,
                            priceText: "",
                            logoURL: $0.attributes.logo,
                            darkModeLogoURL: $0.attributes.logoDark
                        )
                    }
                
                // MARK: Wallets
                
                state.walletAssetsState.basicAssets = user.holdings.attributes.wallets
                    .filter { !$0.attributes.deleted }
                    .sorted {
                        guard let lBalance = Double($0.attributes.balance), let rBalance = Double($1.attributes.balance) else { return false }
                        return lBalance > rBalance
                    }
                    .compactMap { wallet in
                        guard let crytocoin = user.holdings.attributes.cryptocoins.first(where: {
                            $0.id == wallet.attributes.cryptocoinID
                        }) else { return nil }
        
                        return .init(
                            type: .basic,
                            option: .wallet(isDefault: wallet.attributes.isDefault),
                            name: wallet.attributes.name,
                            symbol: wallet.attributes.cryptocoinSymbol,
                            priceText: Double(wallet.attributes.balance)?.toCurrencyString(
                                maximumFractionDigits: crytocoin.attributes.precisionForFiatPrice,
                                symbolCharacter: symbolCharacter
                            ) ?? "",
                            logoURL: crytocoin.attributes.logo,
                            darkModeLogoURL: crytocoin.attributes.logoDark
                        )
                    }
                
                state.walletAssetsState.commodityAssets = user.holdings.attributes.commodityWallets
                    .filter { !$0.attributes.deleted }
                    .sorted {
                        guard let lBalance = Double($0.attributes.balance),
                              let rBalance = Double($1.attributes.balance) else { return false }
                        return lBalance > rBalance
                    }
                    .compactMap { wallet in
                        guard let commodity = user.holdings.attributes.commodities.first(where: {
                            $0.id == wallet.attributes.cryptocoinID
                        }) else { return nil }
                    
                        return .init(
                            type: .commodity,
                            option: .wallet(isDefault: wallet.attributes.isDefault),
                            name: wallet.attributes.name,
                            symbol: wallet.attributes.cryptocoinSymbol,
                            priceText: Double(wallet.attributes.balance)?.toCurrencyString(
                                maximumFractionDigits: commodity.attributes.precisionForFiatPrice,
                                symbolCharacter: symbolCharacter
                            ) ?? "",
                            logoURL: commodity.attributes.logo,
                            darkModeLogoURL: commodity.attributes.logoDark
                        )
                }
                
                state.walletAssetsState.fiatAssets = user.holdings.attributes.fiatWallets
                    .sorted {
                        guard let lBalance = Double($0.attributes.balance),
                              let rBalance = Double($1.attributes.balance) else { return false }
                        return lBalance > rBalance
                    }
                    .compactMap { wallet in
                        guard let fiat = user.holdings.attributes.fiats.first(where: {
                            $0.id == wallet.attributes.fiatId
                        }) else { return nil }
                        
                        return .init(
                            type: .fiat,
                            option: .wallet(isDefault: false),
                            name: wallet.attributes.name,
                            symbol: wallet.attributes.fiatSymbol,
                            priceText: Double(wallet.attributes.balance)?.toCurrencyString(
                                maximumFractionDigits: fiat.attributes.precision,
                                symbolCharacter: symbolCharacter
                            ) ?? "",
                            logoURL: fiat.attributes.logo,
                            darkModeLogoURL: fiat.attributes.logoDark
                        )
                    }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        case .onSelectTab(let tab):
            state.selectedTab = tab
        default:
            break
        }
        
        return .none
    }
)
