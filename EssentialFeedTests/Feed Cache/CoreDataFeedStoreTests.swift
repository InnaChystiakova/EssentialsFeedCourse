//
//  CoreDataFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 16/11/2024.
//

import XCTest
import EssentialFeedFramework

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
    func testRetrieveDeliversEmptyOnEmptyCache() {
        let sut = CoreDataFeedStore()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(sut)
    }
    
    func testRetrieveHasNoSideEffectsOnEmptyCache() {
        let sut = CoreDataFeedStore()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(sut)
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
