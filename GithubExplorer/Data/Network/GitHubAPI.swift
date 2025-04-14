//
//  GitHubAPI.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

protocol GitHubAPI {
    func fetchUsers(page: Int, perPage: Int) async throws -> [UserDTO]
    func fetchUserProfile(username: String) async throws -> UserProfileDTO
    func fetchUserRepos(username: String) async throws -> [RepositoryDTO]
    func fetchRepoDetail(owner: String, repoName: String) async throws -> RepositoryDTO
}
