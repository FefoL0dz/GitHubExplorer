//
//  GetUserListUseCase.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct GetUserListUseCase {
    let repository: UserRepository

    func execute(page: Int, perPage: Int) async throws -> [User] {
        try await repository.fetchUsers(page: page, perPage: perPage)
    }
}

