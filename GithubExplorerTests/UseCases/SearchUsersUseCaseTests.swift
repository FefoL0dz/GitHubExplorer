//
//  SearchUsersUseCaseTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class SearchUsersUseCaseTests: XCTestCase {
    func testExecuteReturnsSearchedUsers() async throws {
        let mockRepo = MockUserRepository()
        let expected = MockDTOFactory.makeUserDTOList(count: 1).map { $0.toDomain() }
        mockRepo.stubbedSearchUsers = expected

        let useCase = SearchUsersUseCase(repository: mockRepo)

        let users = try await useCase.execute(query: "torvalds", page: 1)

        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.username, expected.first?.username)
    }
}

