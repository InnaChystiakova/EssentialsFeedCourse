//
//  LocalFeedImageDataLoaderTests.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 26/04/2025.
//

import XCTest
@testable import EssentialFeedFramework

final class LoadFeedImageDataLoader {
    init(store: Any) {
        
    }
}

class LocalFeedImageDataLoaderTests: XCTestCase {
    func testInitDoesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)

    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file:StaticString = #filePath, line: UInt = #line) -> (sut: LoadFeedImageDataLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LoadFeedImageDataLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private class FeedStoreSpy {
        let receivedMessages = [Any]()
    }
}
