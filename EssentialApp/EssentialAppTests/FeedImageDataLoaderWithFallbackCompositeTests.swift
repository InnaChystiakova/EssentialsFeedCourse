//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 14/01/2026.
//

import XCTest
@testable import EssentialFeedFramework

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    
    private class Task: FeedImageDataLoaderTask {
        func cancel() {
        }
    }
    
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        
    }
    
    func loadImageData(from url: URL,
                       completion: @escaping (FeedImageDataLoader.Result) -> Void
    ) -> FeedImageDataLoaderTask {
        return Task()
    }
}

final class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    
    func testInitDoesNotLoadImageData() {
        let primary = LoaderSpy()
        let fallback = LoaderSpy()
        
        _ = FeedImageDataLoaderWithFallbackComposite(primary: primary, fallback: fallback)
    }
    
    // MARK: - Helpers
    
    private class LoaderSpy: FeedImageDataLoader {
        private class Task: FeedImageDataLoaderTask {
            func cancel() {
            }
        }
        
        func loadImageData(from url: URL,
                           completion: @escaping (FeedImageDataLoader.Result) -> Void
        ) -> FeedImageDataLoaderTask {
            return Task()
        }
    }
}
