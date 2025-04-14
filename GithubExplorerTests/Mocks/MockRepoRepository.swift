//
//  MockRepoRepository.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

@testable import GithubExplorer
import Foundation

final class MockRepoRepository: RepoRepository {
    var stubbedRepos: [Repository] = []
    var stubbedRepoDetail: Repository = MockDTOFactory.makeRepositoryDTO(name: "default").toDomain()

    func fetchRepositories(username: String) async throws -> [Repository] {
        stubbedRepos
    }

    func fetchRepositoryDetail(owner: String, repoName: String) async throws -> Repository {
        stubbedRepoDetail
    }
}
