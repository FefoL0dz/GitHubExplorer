//
//  DebouncedPublisherTests.swift
//  GithubExplorerTests
//
//  Created by Felipe Framework on 14/04/25.
//

import XCTest
import Combine
@testable import GithubExplorer

final class DebouncedPublisherTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testDebouncePublishesLatestValueAfterDelay() {
        let debounced = DebouncedPublisher<String>(initialValue: "")
        let subject = PassthroughSubject<String, Never>()
        var receivedValue: String?
        let expectation = expectation(description: "Debounced value should be emitted")

        debounced.$value
            .dropFirst()
            .sink { value in
                receivedValue = value
                expectation.fulfill()
            }
            .store(in: &cancellables)

        debounced.setup(
            source: subject.eraseToAnyPublisher(),
            delay: 0.3,
            mode: .debounce
        )

        subject.send("First")
        subject.send("Second")
        subject.send("Third")

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValue, "Third")
    }

    func testThrottleSkipsIntermediateValues() {
        let throttled = DebouncedPublisher<String>(initialValue: "")
        let subject = PassthroughSubject<String, Never>()
        var receivedValues: [String] = []
        let expectation = expectation(description: "Throttle should emit first and last")

        throttled.setup(
            source: subject.eraseToAnyPublisher(),
            delay: 0.2,
            mode: .throttle
        )

        throttled.$value
            .dropFirst()
            .sink { value in
                print("🚀 received:", value)
                receivedValues.append(value)
                if receivedValues.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        subject.send("A")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            subject.send("B")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            subject.send("C")
        }

        wait(for: [expectation], timeout: 1.5)

        XCTAssertEqual(receivedValues.first, "A")
    }
}
