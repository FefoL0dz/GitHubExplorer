//
//  RepoRepositoryImplTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class RepoRepositoryImplTests: XCTestCase {

    private var mockAPI: MockGitHubAPI!
    private var repository: RepoRepositoryImpl!

    override func setUp() {
        super.setUp()
        mockAPI = MockGitHubAPI()
        repository = RepoRepositoryImpl(api: mockAPI)
    }

    func testFetchRepositoriesReturnsDomainRepositories() async throws {
        let dtoList = MockDTOFactory.makeRepositoryDTOList(count: 3)
        mockAPI.stubbedRepos = dtoList

        let result = try await repository.fetchRepositories(username: "mock")

        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result.first?.name, dtoList.first?.name)
    }

    func testFetchRepositoryDetailReturnsCorrectRepo() async throws {
        let dto = MockDTOFactory.makeRepositoryDTO(name: "target-repo")
        mockAPI.stubbedRepoDetail = dto

        let result = try await repository.fetchRepositoryDetail(owner: "mock", repoName: "target-repo")

        XCTAssertEqual(result.name, "target-repo")
        XCTAssertEqual(result.stars, dto.stars)
    }
}
