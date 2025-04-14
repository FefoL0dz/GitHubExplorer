//
//  RepoRepositoryMock.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import Foundation
@testable import GithubExplorer

final class RepoRepositoryMock: RepoRepository {
    var shouldFail = false

    var mockedRepositories: [Repository] = [
        Repository(
            id: 1,
            name: "MockRepo",
            description: "Awesome mock repo",
            primaryLanguage: "Swift",
            stars: 100,
            forks: 20,
            openIssues: 5,
            isPrivate: false,
            isArchived: false,
            lastUpdated: Date(),
            htmlURL: URL(string: "https://github.com/mock/repo")!
        )
    ]

    func fetchRepositories(username: String) async throws -> [Repository] {
        if shouldFail { throw GitHubAPIError.httpError(500) }
        return mockedRepositories
    }

    func fetchRepositoryDetail(owner: String, repoName: String) async throws -> Repository {
        if shouldFail { throw GitHubAPIError.httpError(404) }
        return mockedRepositories.first { $0.name == repoName } ?? mockedRepositories[0]
    }
}
