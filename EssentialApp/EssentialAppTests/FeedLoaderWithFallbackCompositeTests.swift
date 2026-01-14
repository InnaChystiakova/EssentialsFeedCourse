//
//  RemoteWithLocalFallbackFeedLoaderTests.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 14/01/2026.
//

import XCTest
import EssentialFeedFramework

/// We can use concrete abstractions to prevent order misundertanding like
/// let sut = RemoteWithLocalFallbackFeedLoader(remote: localLoader, local: remoteLoader)
/// instead of
/// let sut = RemoteWithLocalFallbackFeedLoader(remote: remoteLoader, local: localLoader)
/*
protocol RemoteFeedLoader: FeedLoader {}
protocol LocalFeedLoader: FeedLoader {}

extension EssentialFeedFramework.RemoteFeedLoader: RemoteFeedLoader {}
extension EssentialFeedFramework.LocalFeedLoader: LocalFeedLoader {}


class RemoteWithLocalFallbackFeedLoader {
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        
    }
}
 */

class FeedLoaderWithFallbackComposite: FeedLoader {
    private let primary: FeedLoader
    
    init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primary.load(completion: completion)
    }
}

class FeedLoaderWithFallbackCompositeTests: XCTestCase {
    
    func testLoadDeliversPrimaryFeedOnPrimaryLoadSuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let primaryLoader = LoaderStub(result: .success(primaryFeed))          //RemoteLoaderStub()
        let fallbackLoader = LoaderStub(result: .success(fallbackFeed))        //LocalLoaderStub()
        let sut = FeedLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
                case let .success(receivedFeed):
                XCTAssertEqual(receivedFeed, primaryFeed)
            case .failure:
                XCTFail("Expected successful load feed result, got \(result) instead.")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func uniqueFeed() -> [FeedImage] {
        return [FeedImage(id: UUID(),
                          description: "any",
                          location: "any",
                          url: URL(string: "http//any-url.com")!
                         )]
    }
    
    private class LoaderStub: FeedLoader {
        private let result: FeedLoader.Result
        
        init(result: FeedLoader.Result) {
            self.result = result
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completion(result)
        }
    }
    
    ///Use these stubs to keep order inside the system under test (sut)
    /*
    private class RemoteLoaderStub: RemoteFeedLoader {
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            
        }
    }
    
    private class LocalLoaderStub: LocalFeedLoader {
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            
        }
    }
     */
}
