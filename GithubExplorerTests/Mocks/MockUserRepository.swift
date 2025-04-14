//
//  MockUserRepository.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

@testable import GithubExplorer
import Foundation

final class MockUserRepository: UserRepository {
    var stubbedUsers: [User] = []
    var stubbedSearchUsers: [User] = []
    var stubbedUserProfile: UserProfile = MockDTOFactory.makeUserProfileDTO().toDomain()

    func fetchUsers(page: Int, perPage: Int) async throws -> [User] {
        stubbedUsers
    }

    func searchUsers(query: String, page: Int) async throws -> [User] {
        stubbedSearchUsers
    }

    func fetchUserProfile(username: String) async throws -> UserProfile {
        stubbedUserProfile
    }
}

