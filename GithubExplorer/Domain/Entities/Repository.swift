//
//  Repository.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct Repository: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let primaryLanguage: String?
    let stars: Int
    let forks: Int
    let openIssues: Int
    let isPrivate: Bool
    let isArchived: Bool
    let lastUpdated: Date
    let htmlURL: URL
}

