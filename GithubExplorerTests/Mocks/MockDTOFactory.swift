//
//  MockDTOFactory.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import Foundation
@testable import GithubExplorer

enum MockDTOFactory {
        
    static func makeUserDTO(
        id: Int = 1,
        login: String = "mockuser",
        avatarURL: String = "https://mock.url"
    ) -> UserDTO {
        return UserDTO(id: id, login: login, avatarURL: avatarURL)
    }
    
    static func makeUserDTOList(count: Int) -> [UserDTO] {
        return (1...count).map {
            makeUserDTO(id: $0, login: "user\($0)", avatarURL: "https://mock.url/\($0)")
        }
    }
        
    static func makeUserProfileDTO(
        id: Int = 1,
        login: String = "mockuser",
        name: String? = "Mock User",
        bio: String? = "This is a bio",
        followers: Int = 10,
        following: Int = 5,
        avatarURL: String = "https://mock.url"
    ) -> UserProfileDTO {
        return UserProfileDTO(
            id: id,
            login: login,
            name: name,
            bio: bio,
            avatarURL: avatarURL,
            followers: followers,
            following: following
        )
    }

    static func makeRepositoryDTO(
        id: Int = 1,
        name: String = "MockRepo",
        description: String? = "Mock repo description",
        language: String? = "Swift",
        stars: Int = 123,
        forks: Int = 45,
        issues: Int = 7,
        isPrivate: Bool = false,
        isArchived: Bool = false,
        updatedAt: Date = Date(),
        htmlURL: String = "https://github.com/mock/repo"
    ) -> RepositoryDTO {
        let formatter = ISO8601DateFormatter()
        return RepositoryDTO(
            id: id,
            name: name,
            description: description,
            language: language,
            stars: stars,
            forks: forks,
            openIssues: issues,
            isPrivate: isPrivate,
            isArchived: isArchived,
            updatedAt: formatter.string(from: updatedAt),
            htmlURL: htmlURL
        )
    }

    static func makeRepositoryDTOList(count: Int) -> [RepositoryDTO] {
        return (1...count).map {
            makeRepositoryDTO(id: $0, name: "Repo\($0)", htmlURL: "https://github.com/mock/repo\($0)")
        }
    }
    
    static func makeUserSearchResponseDTO(count: Int) -> UserSearchResponseDTO {
        let items = makeUserDTOList(count: count)
        return UserSearchResponseDTO(totalCount: count, incompleteResults: false, items: items)
    }
}
