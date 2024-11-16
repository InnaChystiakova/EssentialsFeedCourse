//
//  CodableFeedStoreTests.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 03/11/2024.
//

import XCTest
@testable import EssentialFeedFramework

typealias FailableFeedStoreSpecs = FailableRetrieveFeedStoreSpecs & FailableInsertFeedStoreSpecs & FailableDeleteFeedStoreSpecs

final class CodableFeedStoreTests: XCTestCase, FailableFeedStoreSpecs {
    
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
    
    func testRetrieveDeliversFailureOnRetrievealError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)

        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
        
        assertThatRetrieveDeliversFailureOnRetrievalError(on: sut)
    }
    
    func testRetrieveHasNoSideEffectsOnFailure() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
        
        assertThatRetrieveHasNoSideEffectsOnFailure(on: sut)
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
    
    func testInsertDeliversErrorOnInsertionError() {
        let invalidStoreURL = URL(string: "invalid://store-url")!
        let sut = makeSUT(storeURL: invalidStoreURL)
        
        assertThatInsertDeliversErrorOnInsertionError(on: sut)
    }
    
    func testInsertHasNoSideEffectsOnInsertionError() {
        let invalidStoreURL = URL(string: "invalid://store-url")!
        let sut = makeSUT(storeURL: invalidStoreURL)
        
        assertThatInsertHasNoSideEffectsOnInsertionError(on: sut)
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
        let sut = makeSUT()
        
        assertThatDeleteEmptiesPreviouslyInsertedCache(sut)
    }
    
    func testDeleteDeliversErrorOnDeletionError() {
        let noDeletePermissionsURL = cachesDirectory()
        let sut = makeSUT(storeURL: noDeletePermissionsURL)
        
        let deletionError = deleteCache(from: sut)

        XCTAssertNotNil(deletionError, "Expected cache deletion to fail")
    }
    
    func testDeleteHasNoSideEffectsOnDeletionError() {
        let noDeletePermissionsURL = cachesDirectory()
        let sut = makeSUT(storeURL: noDeletePermissionsURL)
        
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .empty)
    }
    
    func testStoreSideEffectsRunSerially() {
        let sut = makeSUT()
        
        assertThatSideEffectsRunSerially(sut)
    }
    
    // MARK: -Helpers
    
    private func makeSUT(storeURL: URL? = nil, file: StaticString = #filePath, line: UInt = #line) -> FeedStore {
        let sut = CodableFeedStore(storeURL: storeURL ?? testSpecificStoreURL())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
}
