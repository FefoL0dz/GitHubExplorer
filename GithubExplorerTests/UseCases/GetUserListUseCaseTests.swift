//
//  GetUserListUseCaseTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class GetUserListUseCaseTests: XCTestCase {
    func testExecuteReturnsUsersFromRepository() async throws {
        let mockRepo = MockUserRepository()
        let expectedUsers = MockDTOFactory.makeUserDTOList(count: 2).map { $0.toDomain() }
        mockRepo.stubbedUsers = expectedUsers

        let useCase = GetUserListUseCase(repository: mockRepo)

        let users = try await useCase.execute(page: 1, perPage: 30)

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users.first?.id, expectedUsers.first?.id)
    }
}
