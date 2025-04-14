//
//  UserRepositoryImpl.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let api: GitHubAPI
    private let urlSession: URLSession


    init(api: GitHubAPI = GitHubAPIClient(), urlSession: URLSession = .shared) {
        self.api = api
        self.urlSession = urlSession
    }

    func fetchUsers(page: Int, perPage: Int) async throws -> [User] {
        let dtos = try await api.fetchUsers(page: page, perPage: perPage)
        return dtos.map { $0.toDomain() }
    }

    func searchUsers(query: String, page: Int) async throws -> [User] {
        guard !query.isEmpty else { return [] }

        let urlStr = "https://api.github.com/search/users?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)&per_page=30"

        guard let url = URL(string: urlStr) else {
            throw GitHubAPIError.invalidURL
        }

        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw GitHubAPIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        let result = try JSONDecoder().decode(UserSearchResponseDTO.self, from: data)
        return result.items.map { $0.toDomain() }
    }

    func fetchUserProfile(username: String) async throws -> UserProfile {
        let dto = try await api.fetchUserProfile(username: username)
        return dto.toDomain()
    }
}

