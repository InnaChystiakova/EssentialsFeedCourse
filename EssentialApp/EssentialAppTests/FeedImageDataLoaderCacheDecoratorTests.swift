//
//  FeedImageDataLoaderCacheDecoratorTests.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import XCTest
import EssentialFeedFramework

class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private struct Task : FeedImageDataLoaderTask {
        func cancel() { }
    }
    
    init(decoratee: FeedImageDataLoader) {
        self.decoratee = decoratee
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        decoratee.loadImageData(from: url, completion: completion)
    }
}

class FeedImageDataLoaderCacheDecoratorTests: XCTestCase {
    
    func testInitDoesNotLoadImageData() {
        let (_, loader) = makeSUT()
        
        XCTAssertTrue(loader.loadedURLs.isEmpty, "Expected not loaded URLs")
    }
    
    func testLoadImageDataLoadsFromLoader() {
        let url = anyURL()
        let (sut, loader) = makeSUT()
        
        _ = sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(loader.loadedURLs, [url], "Expected to load URL from loader")
    }
    
    func testCancelLoadImageDataCancelsLoaderTaqsk() {
        let url = anyURL()
        let (sut, loader) = makeSUT()
        
        let task = sut.loadImageData(from: url) { _ in }
        task.cancel()
        
        XCTAssertEqual(loader.cancelledURLs, [url], "Expected to cancel URL loading from loader")
    }
    
    func testLoadImageDataDeliversDataOnLoaderSuccess() {
        let imageData = anyData()
        let (sut, loader) = makeSUT()
        
        expect(sut, toCompleteWith: .success(imageData)) {
            loader.complete(with: imageData)
        }
    }
    
    func testLoadImageDataDeliversDataOnLoaderFailure() {
        let error = anyNSError()
        let (sut, loader) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(error)) {
            loader.complete(with: error)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (FeedImageDataLoaderCacheDecorator, FeedImageLoaderSpy) {
        let loader = FeedImageLoaderSpy()
        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    private func expect(_ sut: FeedImageDataLoader,
                        toCompleteWith expectedResult: FeedImageDataLoader.Result,
                        when action: () -> Void,
                        file: StaticString = #file,
                        line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        _ = sut.loadImageData(from: anyURL()) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedFeed), .success(expectedFeed)):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
}
