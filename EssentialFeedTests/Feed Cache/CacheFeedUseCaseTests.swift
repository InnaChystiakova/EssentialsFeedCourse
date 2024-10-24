//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 24/10/2024.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {
        
    }
}

class FeedStore {
    var deleteCachedFeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {
    
    func test() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
     
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
    
}
