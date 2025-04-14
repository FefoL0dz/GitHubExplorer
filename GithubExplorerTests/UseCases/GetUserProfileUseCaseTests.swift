//
//  GetUserProfileUseCaseTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class GetUserProfileUseCaseTests: XCTestCase {
    func testExecuteReturnsUserProfile() async throws {
        let mockRepo = MockUserRepository()
        let expected = MockDTOFactory.makeUserProfileDTO().toDomain()
        mockRepo.stubbedUserProfile = expected

        let useCase = GetUserProfileUseCase(repository: mockRepo)

        let profile = try await useCase.execute(username: "torvalds")

        XCTAssertEqual(profile.user.username, expected.user.username)
        XCTAssertEqual(profile.bio, expected.bio)
    }
}

