//
//  UserRepositoryImplTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class UserRepositoryImplTests: XCTestCase {

    private var mockAPI: MockGitHubAPI!
    private var repository: UserRepositoryImpl!

    override func setUp() {
        super.setUp()
        mockAPI = MockGitHubAPI()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)

        repository = UserRepositoryImpl(api: mockAPI, urlSession: mockSession)
    }

    func testFetchUsersReturnsDomainUsers() async throws {
        let expectedUsers = MockDTOFactory.makeUserDTOList(count: 2)
        mockAPI.stubbedUsers = expectedUsers

        let result = try await repository.fetchUsers(page: 1, perPage: 30)

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.username, expectedUsers.first?.login)
    }

    func testSearchUsersReturnsDomainUsers() async throws {
        let expectedUsers = MockDTOFactory.makeUserDTOList(count: 1)
        let json = try JSONEncoder().encode(UserSearchResponseDTO(totalCount: 1, incompleteResults: false, items: expectedUsers))
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json)
        }

        let result = try await repository.searchUsers(query: "mock", page: 1)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.username, "user1")
    }

    func testFetchUserProfileReturnsDomainUserProfile() async throws {
        let dto = MockDTOFactory.makeUserProfileDTO()
        mockAPI.stubbedUserProfile = dto

        let result = try await repository.fetchUserProfile(username: "mockuser")

        XCTAssertEqual(result.user.username, dto.login)
        XCTAssertEqual(result.bio, dto.bio)
    }
}
