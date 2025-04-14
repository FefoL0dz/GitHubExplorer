//
//  RepoRepositoryImpl.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

final class RepoRepositoryImpl: RepoRepository {
    private let api: GitHubAPI

    init(api: GitHubAPI = GitHubAPIClient()) {
        self.api = api
    }

    func fetchRepositories(username: String) async throws -> [Repository] {
        let dtos = try await api.fetchUserRepos(username: username)
        return dtos.map { $0.toDomain() }
    }
    
    func fetchRepositoryDetail(owner: String, repoName: String) async throws -> Repository {
        let dto = try await api.fetchRepoDetail(owner: owner, repoName: repoName)
        return dto.toDomain()
    }
}

