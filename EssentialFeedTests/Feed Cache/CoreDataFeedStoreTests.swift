//
//  CoreDataFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 16/11/2024.
//

import XCTest
import EssentialFeedFramework

class CoreDataFeedStore: FeedStore {
    public init() {}
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func insert(_ feed: [EssentialFeedFramework.LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
}

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
    func testRetrieveDeliversEmptyOnEmptyCache() {
        let sut = CoreDataFeedStore()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(sut)
    }
    
    func testRetrieveHasNoSideEffectsOnEmptyCache() {
        
    }
    
    func testRetrieveDeliversFoundValuesOnNonEmptyCache() {
        
    }
    
    func testRetrieveHasNoSideEffectsOnNonEmptyCache() {
        
    }
    
    func testInsertDeliversNoErrorOnEmptyCache() {
        
    }
    
    func testInsertDeliversNoErrorOnNonEmptyCache() {
        
    }
    
    func testInsertOverridesPreviouslyInsertedCacheValues() {
        
    }
    
    func testDeleteDeliversNoErrorOnEmptyCache() {
        
    }
    
    func testDeleteHasNoSideEffectsOnEmptyCache() {
        
    }
    
    func testDeleteDeliversNoErrorOnNonEmptyCache() {
        
    }
    
    func testDeleteEmptiesPreviouslyInsertedCache() {
        
    }
    
    func testStoreSideEffectsRunSerially() {
        
    }
    
    //MARK: -Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> FeedStore {
        let sut = CoreDataFeedStore()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
