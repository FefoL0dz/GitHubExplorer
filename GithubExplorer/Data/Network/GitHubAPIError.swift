//
//  GitHubAPIError.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation
enum GitHubAPIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case httpError(Int)
}

extension GitHubAPIError: Equatable {
    static func == (lhs: GitHubAPIError, rhs: GitHubAPIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.httpError(let a), .httpError(let b)):
            return a == b
        default:
            return false
        }
    }
}
