//
//  UserRepository.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

protocol UserRepository {
    func fetchUsers(page: Int, perPage: Int) async throws -> [User]
    func searchUsers(query: String, page: Int) async throws -> [User]
    func fetchUserProfile(username: String) async throws -> UserProfile
}

