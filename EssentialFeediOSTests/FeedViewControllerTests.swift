//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Inna Chystiakova on 06/04/2025.
//

import XCTest

final class FeedViewController {
    init(loader: FeedViewControllerTests.LoaderSpy) {
        
    }
}

final class FeedViewControllerTests: XCTestCase {

    func testInitDoesNotLoadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }

    // MARK: - Helpers
    
    class LoaderSpy {
        private(set) var loadCallCount = 0
        
        
    }
}
