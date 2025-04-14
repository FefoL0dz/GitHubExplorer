//
//  GetUserProfileUseCase.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct GetUserProfileUseCase {
    let repository: UserRepository

    func execute(username: String) async throws -> UserProfile {
        try await repository.fetchUserProfile(username: username)
    }
}

