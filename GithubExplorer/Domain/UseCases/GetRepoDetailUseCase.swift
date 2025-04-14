//
//  GetRepoDetailUseCase.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct GetRepoDetailUseCase {
    let repository: RepoRepository

    func execute(owner: String, name: String) async throws -> Repository {
        try await repository.fetchRepositoryDetail(owner: owner, repoName: name)
    }
}

