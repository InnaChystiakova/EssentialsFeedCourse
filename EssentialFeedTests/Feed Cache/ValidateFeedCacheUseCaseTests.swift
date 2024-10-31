//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 31/10/2024.
//

import XCTest
import EssentialFeed

final class ValidateFeedCacheUseCaseTests: XCTestCase {

    func testInitDoesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
     
        XCTAssertEqual(store.receivedMessages, [])
    }

    //MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
}
