//
//  GetRepoDetailUseCaseTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class GetRepoDetailUseCaseTests: XCTestCase {
    func testExecuteReturnsRepositoryDetail() async throws {
        let mockRepo = MockRepoRepository()
        let expected = MockDTOFactory.makeRepositoryDTO(name: "linux").toDomain()
        mockRepo.stubbedRepoDetail = expected

        let useCase = GetRepoDetailUseCase(repository: mockRepo)

        let repo = try await useCase.execute(owner: "torvalds", name: "linux")

        XCTAssertEqual(repo.name, "linux")
        XCTAssertEqual(repo.stars, expected.stars)
    }
}
