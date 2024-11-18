//
//  CoreDataFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 16/11/2024.
//

import XCTest
import EssentialFeedFramework

class CoreDataFeedStoreTests: XCTestCase, FeedStoreSpecs {
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }
    
    func testRetrieveDeliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(sut)
    }
    
    func testRetrieveHasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(sut)
    }
    
    func testRetrieveDeliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(sut)
    }
    
    func testRetrieveHasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(sut)
    }
    
    func testInsertDeliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatInsertDeliversNoErrorOnEmptyCache(sut)
    }
    
    func testInsertDeliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatInsertDeliversNoErrorOnNonEmptyCache(sut)
    }
    
    func testInsertOverridesPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        assertThatInsertOverridesPreviouslyInsertedCacheValues(sut)
    }
    
    func testDeleteDeliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnEmptyCache(sut)
    }
    
    func testDeleteHasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteHasNoSideEffectsOnEmptyCache(sut)
    }
    
    func testDeleteDeliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnNonEmptyCache(sut)
    }
    
    func testDeleteEmptiesPreviouslyInsertedCache() {
        
    }
    
    func testStoreSideEffectsRunSerially() {
        
    }
    
    //MARK: -Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> FeedStore {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = uniqueTestSpecificStoreURL()//URL(fileURLWithPath: "dev/null")
        let sut = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: uniqueTestSpecificStoreURL())
    }
    
    private func uniqueTestSpecificStoreURL() -> URL {
        let manager = FileManager.default
        let dir = manager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent((UUID().uuidString))
    }
}
