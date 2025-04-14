//
//  GitHubAPIClient.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

final class GitHubAPIClient: GitHubAPI {
    private let baseURL = "https://api.github.com"
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
       // self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchUsers(page: Int = 1, perPage: Int = 30) async throws -> [UserDTO] {
        guard let url = URL(string: "\(baseURL)/search/users?q=type:user&page=\(page)&per_page=\(perPage)") else {
            throw GitHubAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw GitHubAPIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        do {
            let result = try decoder.decode(UserSearchResponseDTO.self, from: data)
            return result.items
        } catch {
            print("⚠️ Decoding error: \(error)")
            throw GitHubAPIError.decodingError(error)
        }
    }

    func fetchUserProfile(username: String) async throws -> UserProfileDTO {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            throw GitHubAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw GitHubAPIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        return try decoder.decode(UserProfileDTO.self, from: data)
    }

    func fetchUserRepos(username: String) async throws -> [RepositoryDTO] {
        guard let url = URL(string: "\(baseURL)/users/\(username)/repos") else {
            throw GitHubAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw GitHubAPIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        return try decoder.decode([RepositoryDTO].self, from: data)
    }
    
    func fetchRepoDetail(owner: String, repoName: String) async throws -> RepositoryDTO {
        guard let url = URL(string: "\(baseURL)/repos/\(owner)/\(repoName)") else {
            throw GitHubAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw GitHubAPIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        return try decoder.decode(RepositoryDTO.self, from: data)
    }
}

