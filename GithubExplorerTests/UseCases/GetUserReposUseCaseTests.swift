//
//  GetUserReposUseCaseTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class GetUserReposUseCaseTests: XCTestCase {
    func testExecuteReturnsRepositories() async throws {
        let mockRepo = MockRepoRepository()
        let expected = MockDTOFactory.makeRepositoryDTOList(count: 3).map { $0.toDomain() }
        mockRepo.stubbedRepos = expected

        let useCase = GetUserReposUseCase(repository: mockRepo)

        let repos = try await useCase.execute(username: "torvalds")

        XCTAssertEqual(repos.count, 3)
        XCTAssertEqual(repos.first?.name, expected.first?.name)
    }
}
