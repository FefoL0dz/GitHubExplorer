//
//  RepositoryDTO.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//
//

import Foundation

struct RepositoryDTO: Codable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stars: Int
    let forks: Int
    let openIssues: Int
    let isPrivate: Bool
    let isArchived: Bool
    let updatedAt: String
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case language
        case stars = "stargazers_count"
        case forks = "forks_count"
        case openIssues = "open_issues_count"
        case isPrivate = "private"
        case isArchived = "archived"
        case updatedAt = "updated_at"
        case htmlURL = "html_url"
    }

    func toDomain() -> Repository {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: updatedAt) ?? Date()
        return Repository(
            id: id,
            name: name,
            description: description,
            primaryLanguage: language,
            stars: stars,
            forks: forks,
            openIssues: openIssues,
            isPrivate: isPrivate,
            isArchived: isArchived,
            lastUpdated: date,
            htmlURL: URL(string: htmlURL) ?? URL(string: "https://github.com")!
        )
    }
}

