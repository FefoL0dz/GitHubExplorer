//
//  User.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: Int
    let username: String
    let avatarURL: URL
}
