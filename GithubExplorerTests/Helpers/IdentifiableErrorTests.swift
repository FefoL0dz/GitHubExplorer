//
//  IdentifiableErrorTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import Foundation
import XCTest
@testable import GithubExplorer

final class IdentifiableErrorTests: XCTestCase {

    func testInitWithMessage() {
        let message = "Something went wrong"
        let error = IdentifiableError(message: message)

        XCTAssertEqual(error.message, message)
        XCTAssertNotNil(error.id)
    }

    func testIdentifiableConformance() {
        let error1 = IdentifiableError(message: "Error 1")
        let error2 = IdentifiableError(message: "Error 2")

        XCTAssertNotEqual(error1.id, error2.id)
        XCTAssertEqual(error1.message, "Error 1")
        XCTAssertEqual(error2.message, "Error 2")
    }
}

