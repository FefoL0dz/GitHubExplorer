//
//  RepositoryTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class RepositoryTests: XCTestCase {

    func testRepositoryInitialization() {
        let url = URL(string: "https://github.com/repo")!
        let date = Date()

        let repo = Repository(
            id: 99,
            name: "AwesomeRepo",
            description: "An awesome GitHub repo.",
            primaryLanguage: "Swift",
            stars: 1500,
            forks: 300,
            openIssues: 25,
            isPrivate: false,
            isArchived: false,
            lastUpdated: date,
            htmlURL: url
        )

        XCTAssertEqual(repo.name, "AwesomeRepo")
        XCTAssertEqual(repo.primaryLanguage, "Swift")
        XCTAssertEqual(repo.stars, 1500)
        XCTAssertEqual(repo.lastUpdated, date)
        XCTAssertFalse(repo.isPrivate)
    }

    func testRepositoryEqualityAndHashing() {
        let url = URL(string: "https://github.com/repo")!
        let date = Date()

        let repo1 = Repository(
            id: 10,
            name: "TestRepo",
            description: nil,
            primaryLanguage: nil,
            stars: 10,
            forks: 5,
            openIssues: 2,
            isPrivate: false,
            isArchived: false,
            lastUpdated: date,
            htmlURL: url
        )

        let repo2 = repo1 // same instance
        XCTAssertEqual(repo1, repo2)
        XCTAssertEqual(repo1.hashValue, repo2.hashValue)
    }
}

