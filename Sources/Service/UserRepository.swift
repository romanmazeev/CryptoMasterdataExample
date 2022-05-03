//
//  UserRepository.swift
//  CryptoMasterExampleiOSTest
//
//  Created by Roman Mazeev on 08/03/22.
//

import ComposableArchitecture

enum UserRepositoryError: Error {
    case invalidURL
}

struct UserRepository {
    var getUser: () -> Effect<User, Error>
}

extension UserRepository {
    static let live = Self {
        .catching {
            if let url = Bundle.main.url(forResource: "Mastrerdata", withExtension: "json") {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: data)
            } else {
                throw UserRepositoryError.invalidURL
            }
        }
    }
}

extension UserRepository {
    static let failing = Self {
        .failing("UserRepository.getUser")
    }
}
