//
//  RepoRepository.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

protocol RepoRepository {
    func fetchRepositories(username: String) async throws -> [Repository]
    func fetchRepositoryDetail(owner: String, repoName: String) async throws -> Repository
}

