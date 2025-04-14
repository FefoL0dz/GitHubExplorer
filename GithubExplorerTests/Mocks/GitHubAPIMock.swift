//
//  GitHubAPIMock.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import Foundation
@testable import GithubExplorer

final class GitHubAPIMock: GitHubAPI {
    
    var shouldFail = false

    var mockedUsers: [UserDTO] = [
        UserDTO(id: 1, login: "mockuser", avatarURL: "https://mock.url")
    ]

    var mockedUserProfile: UserProfileDTO = UserProfileDTO(
        id: 1,
        login: "mockuser",
        name: "Mock User",
        bio: "This is a mock user",
        avatarURL: "https://mock.url",
        followers: 10,
        following: 5
    )

    var mockedRepositories: [RepositoryDTO] = [
        RepositoryDTO(
            id: 1,
            name: "MockRepo",
            description: "Mock description",
            language: "Swift",
            stars: 42,
            forks: 10,
            openIssues: 3,
            isPrivate: false,
            isArchived: false,
            updatedAt: ISO8601DateFormatter().string(from: Date()),
            htmlURL: "https://github.com/mock/repo"
        )
    ]

    func fetchUsers(page: Int, perPage: Int) async throws -> [UserDTO] {
        if shouldFail { throw GitHubAPIError.httpError(500) }
        return mockedUsers
    }

    func fetchUserProfile(username: String) async throws -> UserProfileDTO {
        if shouldFail { throw GitHubAPIError.httpError(404) }
        return mockedUserProfile
    }

    func fetchUserRepos(username: String) async throws -> [RepositoryDTO] {
        if shouldFail { throw GitHubAPIError.httpError(400) }
        return mockedRepositories
    }
    func fetchRepoDetail(owner: String, repoName: String) async throws -> RepositoryDTO {
        if shouldFail { throw GitHubAPIError.httpError(400) }
        return mockedRepositories.first!
    }
}

