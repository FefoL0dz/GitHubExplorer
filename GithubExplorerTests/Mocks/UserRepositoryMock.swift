//
//  UserRepositoryMock.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import Foundation
@testable import GithubExplorer

final class UserRepositoryMock: UserRepository {
    var shouldFail = false

    var mockedUsers: [User] = [
        User(id: 1, username: "mockuser", avatarURL: URL(string: "https://mock.url")!)
    ]

    var mockedUserProfile: UserProfile = UserProfile(
        user: User(id: 1, username: "mockuser", avatarURL: URL(string: "https://mock.url")!),
        fullName: "Mock User",
        bio: "Bio here",
        followers: 20,
        following: 10
    )

    func fetchUsers(page: Int, perPage: Int) async throws -> [User] {
        if shouldFail { throw GitHubAPIError.httpError(500) }
        return mockedUsers
    }

    func searchUsers(query: String, page: Int) async throws -> [User] {
        if shouldFail { throw GitHubAPIError.httpError(400) }
        return mockedUsers.filter { $0.username.contains(query) }
    }

    func fetchUserProfile(username: String) async throws -> UserProfile {
        if shouldFail { throw GitHubAPIError.httpError(404) }
        return mockedUserProfile
    }
}

