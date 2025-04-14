//
//  GitHubAPIClientTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
@testable import GithubExplorer

final class GitHubAPIClientTests: XCTestCase {
    private var client: GitHubAPIClient!
    private var session: URLSession!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        client = GitHubAPIClient(session: session)
    }

    func testFetchUsersReturnsUserDTOs() async throws {
        let dtoList = MockDTOFactory.makeUserDTOList(count: 2)
        let responseDTO = UserSearchResponseDTO(totalCount: 2, incompleteResults: false, items: dtoList)
        let json = try JSONEncoder().encode(responseDTO)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json)
        }

        let result = try await client.fetchUsers(page: 1, perPage: 2)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.login, dtoList.first?.login)
    }

    func testFetchUserProfileReturnsDTO() async throws {
        let dto = MockDTOFactory.makeUserProfileDTO()
        let json = try JSONEncoder().encode(dto)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json)
        }

        let result = try await client.fetchUserProfile(username: "torvalds")
        XCTAssertEqual(result.login, dto.login)
        XCTAssertEqual(result.bio, dto.bio)
    }

    func testFetchUserReposReturnsDTOs() async throws {
        let dtos = MockDTOFactory.makeRepositoryDTOList(count: 2)
        let json = try JSONEncoder().encode(dtos)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json)
        }

        let result = try await client.fetchUserRepos(username: "torvalds")
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, dtos.first?.name)
    }

    func testFetchRepoDetailReturnsDTO() async throws {
        let dto = MockDTOFactory.makeRepositoryDTO(name: "linux")
        let json = try JSONEncoder().encode(dto)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json)
        }

        let result = try await client.fetchRepoDetail(owner: "torvalds", repoName: "linux")
        XCTAssertEqual(result.name, "linux")
        XCTAssertEqual(result.stars, dto.stars)
    }

    func testFetchUsersThrowsOnBadStatusCode() async {
        let emptyData = "{}".data(using: .utf8)!

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.github.com")!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, emptyData)
        }

        do {
            _ = try await client.fetchUsers(page: 1, perPage: 30)
            XCTFail("Expected to throw GitHubAPIError.httpError but did not")
        } catch let error as GitHubAPIError {
            switch error {
            case .httpError(let code):
                XCTAssertEqual(code, 500)
            default:
                XCTFail("Expected httpError(500), got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

}

