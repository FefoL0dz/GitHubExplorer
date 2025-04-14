//
//  GetUserReposUseCase.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct GetUserReposUseCase {
    let repository: RepoRepository

    func execute(username: String) async throws -> [Repository] {
        try await repository.fetchRepositories(username: username)
    }
}

