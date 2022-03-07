//
//  Models.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 04/03/22.
//

import Foundation

// MARK: - Welcome
struct User: Codable {
    let holdings: Holdings
    
    enum CodingKeys: String, CodingKey {
        case holdings = "data"
    }
}

// MARK: - Holdings
struct Holdings: Codable {
    let type: String
    let attributes: HoldingAttributes
}

// MARK: - HoldingAttributes
struct HoldingAttributes: Codable {
    let cryptocoins, commodities: [Commodity]
    let fiats: [Fiat]
    let wallets, commodityWallets: [Wallet]
    let fiatWallets: [FiatWallet]

    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets
        case commodityWallets = "commodity_wallets"
        case fiatWallets = "fiatwallets"
    }
}

// MARK: - Commodity
struct Commodity: Codable {
    let id: String
    let type: String
    let attributes: CommodityAttributes
}

// MARK: - CommodityAttributes
struct CommodityAttributes: Codable {
    let symbol, name: String
    let sort: Int
    let assetTypeName: AssetType
    let assetGroupName: AssetGroup
    let urlCheckAddress, urlCheckTransaction: String
    let buyActive, sellActive, withdrawActive, depositActive: Bool
    let transferActive, available, maintenanceEnabled: Bool
    let minBuyEur, minSellEur, minWithdrawEur, defaultSellAmount: String
    let precisionForFiatPrice, precisionForCoins, precisionForTx: Int
    let walletMinDeposit, walletSmallDeposit, walletSmallDepositFee, avgPrice: String
    let color, walletWithdrawFee, change24H, change24HAmount: String
    let change1W, change1WAmount, change1M, change1MAmount: String
    let change1Y, change1YAmount: String
    let logo, logoDark: String
    let supportDestinationTag: Bool
    let circulatingSupply: String?
    let allowedUnverified, allowedDocumented, allowedVerified: Bool
    let measurementUnit: String?
    let ieoPhases: [IeoPhase]
    let info, unavailableReason, maintenanceReason, walletInfo: String
    let extraInfo, infoIntegration, infoDeu, infoEng: String
    let infoFra, unavailableReasonDeu, unavailableReasonEng, unavailableReasonFra: String
    let maintenanceReasonDeu, maintenanceReasonEng, maintenanceReasonFra, walletInfoDeu: String
    let walletInfoEng, walletInfoFra, extraInfoDeu, extraInfoEng: String
    let extraInfoFra, infoIntegrationDeu, infoIntegrationEng, infoIntegrationFra: String
    let investmentInfo, investmentInfoDeu, investmentInfoEng, investmentInfoFra: String?
    let androidSupportedVersion: String?
    let iosSupportedVersion: String?
    let family: Family?

    enum CodingKeys: String, CodingKey {
        case symbol, name, sort
        case assetTypeName = "asset_type_name"
        case assetGroupName = "asset_group_name"
        case urlCheckAddress = "url_check_address"
        case urlCheckTransaction = "url_check_transaction"
        case buyActive = "buy_active"
        case sellActive = "sell_active"
        case withdrawActive = "withdraw_active"
        case depositActive = "deposit_active"
        case transferActive = "transfer_active"
        case available
        case maintenanceEnabled = "maintenance_enabled"
        case minBuyEur = "min_buy_eur"
        case minSellEur = "min_sell_eur"
        case minWithdrawEur = "min_withdraw_eur"
        case defaultSellAmount = "default_sell_amount"
        case precisionForFiatPrice = "precision_for_fiat_price"
        case precisionForCoins = "precision_for_coins"
        case precisionForTx = "precision_for_tx"
        case walletMinDeposit = "wallet_min_deposit"
        case walletSmallDeposit = "wallet_small_deposit"
        case walletSmallDepositFee = "wallet_small_deposit_fee"
        case avgPrice = "avg_price"
        case color
        case walletWithdrawFee = "wallet_withdraw_fee"
        case change24H = "change_24h"
        case change24HAmount = "change_24h_amount"
        case change1W = "change_1w"
        case change1WAmount = "change_1w_amount"
        case change1M = "change_1m"
        case change1MAmount = "change_1m_amount"
        case change1Y = "change_1y"
        case change1YAmount = "change_1y_amount"
        case logo
        case logoDark = "logo_dark"
        case supportDestinationTag = "support_destination_tag"
        case circulatingSupply = "circulating_supply"
        case allowedUnverified = "allowed_unverified"
        case allowedDocumented = "allowed_documented"
        case allowedVerified = "allowed_verified"
        case measurementUnit = "measurement_unit"
        case ieoPhases = "ieo_phases"
        case info
        case unavailableReason = "unavailable_reason"
        case maintenanceReason = "maintenance_reason"
        case walletInfo = "wallet_info"
        case extraInfo = "extra_info"
        case infoIntegration = "info_integration"
        case infoDeu = "info_deu"
        case infoEng = "info_eng"
        case infoFra = "info_fra"
        case unavailableReasonDeu = "unavailable_reason_deu"
        case unavailableReasonEng = "unavailable_reason_eng"
        case unavailableReasonFra = "unavailable_reason_fra"
        case maintenanceReasonDeu = "maintenance_reason_deu"
        case maintenanceReasonEng = "maintenance_reason_eng"
        case maintenanceReasonFra = "maintenance_reason_fra"
        case walletInfoDeu = "wallet_info_deu"
        case walletInfoEng = "wallet_info_eng"
        case walletInfoFra = "wallet_info_fra"
        case extraInfoDeu = "extra_info_deu"
        case extraInfoEng = "extra_info_eng"
        case extraInfoFra = "extra_info_fra"
        case infoIntegrationDeu = "info_integration_deu"
        case infoIntegrationEng = "info_integration_eng"
        case infoIntegrationFra = "info_integration_fra"
        case investmentInfo = "investment_info"
        case investmentInfoDeu = "investment_info_deu"
        case investmentInfoEng = "investment_info_eng"
        case investmentInfoFra = "investment_info_fra"
        case androidSupportedVersion = "android_supported_version"
        case iosSupportedVersion = "ios_supported_version"
        case family
    }
}

enum AssetGroup: String, Codable {
    case coin = "coin"
    case metal = "metal"
}

enum AssetType: String, Codable {
    case commodity = "commodity"
    case cryptocoin = "cryptocoin"
}

enum Family: String, Codable {
    case eth = "ETH"
    case neo = "NEO"
}

// MARK: - IeoPhase
struct IeoPhase: Codable {
    let type: String
    let attributes: IeoPhaseAttributes
    let id: String
}

// MARK: - IeoPhaseAttributes
struct IeoPhaseAttributes: Codable {
    let name: String
    let phaseNumber: Int
    let startDate, endDate: EndDate
    let maxStock, price: String
    let active: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case phaseNumber = "phase_number"
        case startDate = "start_date"
        case endDate = "end_date"
        case maxStock = "max_stock"
        case price, active
    }
}

// MARK: - EndDate
struct EndDate: Codable {
    let dateISO8601: String
    let unix: String

    enum CodingKeys: String, CodingKey {
        case dateISO8601 = "date_iso8601"
        case unix
    }
}

// MARK: - Wallet
struct Wallet: Codable {
    let type: CommodityWalletType
    let attributes: CommodityWalletAttributes
    let id: String
}

// MARK: - CommodityWalletAttributes
struct CommodityWalletAttributes: Codable {
    let cryptocoinID, cryptocoinSymbol, balance: String
    let isDefault: Bool
    let name: String
    let pendingTransactionsCount: Int
    let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case cryptocoinID = "cryptocoin_id"
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case isDefault = "is_default"
        case name
        case pendingTransactionsCount = "pending_transactions_count"
        case deleted
    }
}

enum CommodityWalletType: String, Codable {
    case wallet = "wallet"
}

// MARK: - Fiat
struct Fiat: Codable {
    let type: String
    let attributes: FiatAttributes
    let id: String
}

// MARK: - FiatAttributes
struct FiatAttributes: Codable {
    let symbol, name: String
    let precision: Int
    let toEurRate, defaultSellAmount, numericCharacterReference, minWithdrawEuro: String
    let symbolCharacter: String
    let hasWallets: Bool
    let logo, logoDark, logoWhite, logoColor: String
    let nameDeu, nameEng, nameFra: String

    enum CodingKeys: String, CodingKey {
        case symbol, name, precision
        case toEurRate = "to_eur_rate"
        case defaultSellAmount = "default_sell_amount"
        case numericCharacterReference = "numeric_character_reference"
        case minWithdrawEuro = "min_withdraw_euro"
        case symbolCharacter = "symbol_character"
        case hasWallets = "has_wallets"
        case logo
        case logoDark = "logo_dark"
        case logoWhite = "logo_white"
        case logoColor = "logo_color"
        case nameDeu = "name_deu"
        case nameEng = "name_eng"
        case nameFra = "name_fra"
    }
}

// MARK: - FiatWallet
struct FiatWallet: Codable {
    let id: String
    let type: String
    let attributes: FiatWalletAttributes
}

// MARK: - FiatWalletAttributes
struct FiatWalletAttributes: Codable {
    let fiatId, fiatSymbol, balance, name: String
    let pendingTransactionsCount: Int

    enum CodingKeys: String, CodingKey {
        case balance, name
        case fiatId = "fiat_id"
        case fiatSymbol = "fiat_symbol"
        case pendingTransactionsCount = "pending_transactions_count"
    }
}
