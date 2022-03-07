//
//  WalletsCore.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import ComposableArchitecture

struct WalletsState {
    var user: User?
}

enum WalletsAction: Equatable {
}

struct WalletsEnvironment {
}

let walletsReducer = Reducer<WalletsState, WalletsAction, WalletsEnvironment>.combine(
    .init { state, action, _ in
        .none
    }
)
