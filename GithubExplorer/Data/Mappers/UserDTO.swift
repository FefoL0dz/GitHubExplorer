//
//  UserDTO.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }

    func toDomain() -> User {
        User(
            id: id,
            username: login,
            avatarURL: URL(string: avatarURL) ?? URL(string: "https://github.com")!
        )
    }
}


