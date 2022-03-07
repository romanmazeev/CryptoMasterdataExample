//
//  Repository.swift
//  BitpandaiOSTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import ComposableArchitecture

enum RepositoryError: Error {
    case invalidURL
}

struct Repository {
    var getUser:() -> Effect<User, Error>
}

extension Repository {
    static let live = Self {
        .catching {
            if let url = Bundle.main.url(forResource: "Mastrerdata", withExtension: "json") {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: data)
            } else {
                throw RepositoryError.invalidURL
            }
        }
    }
}

extension Repository {
    static let failing = Self {
        .failing("Repository.getUser")
    }
}
