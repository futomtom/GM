//
//  GMTests.swift
//  GMTests
//
//  Created by Alex Fu on 2/6/21.
//

@testable import GM
import XCTest
import Combine

class GMTests: XCTestCase {
    let timeout: TimeInterval = 2
    var expectation: XCTestExpectation!
    let api = GithubAPI()

    func test_FetchedAndDecodeCommit() {
        let responseReceived = expectation(description: "FetchedAndDecodeCommit")

        var cancellables = Set<AnyCancellable>()
        api.commitPublisher().sink { commits in
            XCTAssertNotNil(commits)
        } receiveValue: { commits in
            XCTAssertGreaterThan(commits.count, 0, "Got at least 1 commit")
            responseReceived.fulfill()
        }
        .store(in: &cancellables)

        waitForExpectations(timeout: timeout)
    }
}
