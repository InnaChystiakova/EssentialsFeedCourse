//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 06/08/2024.
//

import XCTest
@testable import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {
    
    // MARK: - Helpers
    
   private class HTTPClientSpy: HTTPClient {           // Step 3: move the test logic to the new subclass
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()                            // Step 4: change the shared property to the subclass instance
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    //MARK: - Tests

    func testInitDoesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func testLoadRequestDataFromURL() {
        /*
         1. Pass the client into the constructor (constructor injection)
         2. Pass the client to the property after constructor (property injection)
         3. Pass the client as a function parameter (method/dependency injection)
        */
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }

}
