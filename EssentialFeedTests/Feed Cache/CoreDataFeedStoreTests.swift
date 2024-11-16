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
        let sut = makeSUT()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(sut)
    }
    
    func testRetrieveHasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
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
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = URL(fileURLWithPath: "dev/null")
        let sut = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
