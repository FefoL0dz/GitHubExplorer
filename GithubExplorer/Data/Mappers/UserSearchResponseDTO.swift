//
//  UserSearchResponseDTO.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct UserSearchResponseDTO: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserDTO]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}



