//
//  UserProfileTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class UserProfileTests: XCTestCase {
    
    func testUserProfileInitialization() {
        let user = User(id: 100, username: "tester", avatarURL: URL(string: "https://github.com/avatar")!)
        let profile = UserProfile(user: user, fullName: "Test User", bio: "Swift Developer", followers: 120, following: 80)
        
        XCTAssertEqual(profile.user.username, "tester")
        XCTAssertEqual(profile.fullName, "Test User")
        XCTAssertEqual(profile.bio, "Swift Developer")
        XCTAssertEqual(profile.followers, 120)
        XCTAssertEqual(profile.following, 80)
    }
    
    func testUserProfileWithNilValues() {
        let user = User(id: 200, username: "ghost", avatarURL: URL(string: "https://github.com/avatar")!)
        let profile = UserProfile(user: user, fullName: nil, bio: nil, followers: 0, following: 0)
        
        XCTAssertNil(profile.fullName)
        XCTAssertNil(profile.bio)
    }
}

