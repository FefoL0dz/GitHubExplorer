//
//  UserProfileDTO.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

//import Foundation

//struct UserProfileDTO: Codable {
//    let id: Int
//    let login: String
//    let name: String?
//    let bio: String?
//    let avatar_url: String
//    let followers: Int
//    let following: Int
//
//    func toDomain() -> UserProfile {
//        let user = User(id: id, username: login, avatarURL: URL(string: avatar_url)!)
//        return UserProfile(user: user, fullName: name, bio: bio, followers: followers, following: following)
//    }
//}

import Foundation

struct UserProfileDTO: Codable {
    let id: Int
    let login: String
    let name: String?
    let bio: String?
    let avatarURL: String
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case bio
        case avatarURL = "avatar_url"
        case followers
        case following
    }

    func toDomain() -> UserProfile {
        let user = User(id: id, username: login, avatarURL: URL(string: avatarURL)!)
        return UserProfile(user: user, fullName: name, bio: bio, followers: followers, following: following)
    }
}

