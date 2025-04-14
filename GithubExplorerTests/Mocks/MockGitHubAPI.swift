//
//  MockGitHubAPI.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

@testable import GithubExplorer
import Foundation

final class MockGitHubAPI: GitHubAPI {

    var stubbedUsers: [UserDTO] = []
    var stubbedUserProfile: UserProfileDTO = MockDTOFactory.makeUserProfileDTO()
    var stubbedRepos: [RepositoryDTO] = []
    var stubbedRepoDetail: RepositoryDTO = MockDTOFactory.makeRepositoryDTO()

    func fetchUsers(page: Int, perPage: Int) async throws -> [UserDTO] {
        stubbedUsers
    }

    func fetchUserProfile(username: String) async throws -> UserProfileDTO {
        stubbedUserProfile
    }

    func fetchUserRepos(username: String) async throws -> [RepositoryDTO] {
        stubbedRepos
    }

    func fetchRepoDetail(owner: String, repoName: String) async throws -> RepositoryDTO {
        stubbedRepoDetail
    }
}

