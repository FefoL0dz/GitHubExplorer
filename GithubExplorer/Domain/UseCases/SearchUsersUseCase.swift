//
//  SearchUsersUseCase.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct SearchUsersUseCase {
    let repository: UserRepository

    func execute(query: String, page: Int) async throws -> [User] {
        try await repository.searchUsers(query: query, page: page)
    }
}
