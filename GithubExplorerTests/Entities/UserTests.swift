//
//  UserTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class UserTests: XCTestCase {
    
    func testUserInitialization() {
        let url = URL(string: "https://avatars.githubusercontent.com/u/1")!
        let user = User(id: 1, username: "octocat", avatarURL: url)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.username, "octocat")
        XCTAssertEqual(user.avatarURL, url)
    }
    
    func testUserHashableAndEquatable() {
        let url = URL(string: "https://github.com/avatar")!
        let user1 = User(id: 42, username: "john", avatarURL: url)
        let user2 = User(id: 42, username: "john", avatarURL: url)
        
        XCTAssertEqual(user1, user2)
        XCTAssertEqual(user1.hashValue, user2.hashValue)
    }
}

