//
//  MainCore.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import ComposableArchitecture

struct MainState {
    enum Tab: Int, CaseIterable, Equatable {
        case assets
        case wallets
    }
    
    var assets = AssetsState()
    var wallets = WalletsState()
    
    var selectedTab: Tab = .assets
}

enum MainAction {
    case onDidLoad
    case onSelectTab(MainState.Tab)
    
    case assets(AssetsAction)
    case wallets(WalletsAction)
    
    case onReceiveUser(Result<User, Error>)
}

struct MainEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let repository: Repository
}

let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
    .init { state, action, environment in
        switch action {
        case .onDidLoad:
            return environment.repository.getUser()
                .receive(on: environment.mainQueue)
                .catchToEffect(MainAction.onReceiveUser)
        case .onReceiveUser(let result):
            switch result {
            case .success(let user):
                state.assets = .init(user: user)
                state.wallets = .init(user: user)
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
