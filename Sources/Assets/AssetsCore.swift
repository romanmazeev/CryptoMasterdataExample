//
//  AssetsCore.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import ComposableArchitecture

struct AssetsState {
    var user: User?
}

enum AssetsAction: Equatable {
    case onSelectTab(MainState.Tab)
}

struct AssetsEnvironment {
}

let assetsReducer = Reducer<AssetsState, AssetsAction, AssetsEnvironment>.combine(
    .init { state, action, _ in
        return .none
    }
)
