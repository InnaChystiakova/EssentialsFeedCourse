//
//  RemoteWithLocalFallbackFeedLoaderTests.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 14/01/2026.
//

import XCTest
import EssentialFeedFramework
import EssentialApp

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

class FeedLoaderWithFallbackCompositeTests: XCTestCase, FeedLoaderTestCase {
    
    func testLoadDeliversPrimaryFeedOnPrimaryLoadSuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .success(primaryFeed), fallbackResult: .success(fallbackFeed))
        
        expect(sut, toCompleteWith: .success(primaryFeed))
    }
    
    func testLoadDeliversFallbackFeedOnPrimaryFailure() {
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .failure(anyNSError()),
                          fallbackResult: .success(fallbackFeed))
        
        expect(sut, toCompleteWith: .success(fallbackFeed))
    }
    
    func testLoadDeliversErrorOnBothPrimaryAndFallbackLoaderFailure() {
        let sut = makeSUT(primaryResult: .failure(anyNSError()),
                          fallbackResult: .failure(anyNSError()))
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedLoader.Result,
                         fallbackResult: FeedLoader.Result,
                         file: StaticString = #file,
                         line: UInt = #line) -> FeedLoader {
        let primaryLoader = FeedLoaderStub(result: primaryResult)          //RemoteLoaderStub()
        let fallbackLoader = FeedLoaderStub(result: fallbackResult)        //LocalLoaderStub()

        let sut = FeedLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)

        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
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
