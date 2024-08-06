//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 06/08/2024.
//

import XCTest

final class RemoteFeedLoaderTests: XCTestCase {
    
    class RemoteFeedLoader {
        func load() {
            HTTPClient.shared.get(from: URL(string: "https://a-given-url.com")!)        // Step 2: move from property to a method invoke
        }
    }
    
    class HTTPClient {
        static var shared = HTTPClient()        // Step 1: not a singleton anymore
                                                // Step 5: remove rpivate initializer, since it is not a singleton anymore
        func get(from url: URL) {}              // Step 2: assign a parameter instead of a singleton property
    }
    
    
    class HTTPClientSpy: HTTPClient {           // Step 3: move the test logic to the new subclass
        var requestedURL: URL?
        
        override func get(from url: URL) {
            var requestedURL = url
        }
    }

    func testInitDoesNotRequestDataFromURL() {
        let client = HTTPClientSpy()                // Step 4: change the shared property to the subclass instance
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func testLoadRequestDataFromURL() {
        let client = HTTPClientSpy()                // Step 4: change the shared property to the subclass instance
        HTTPClient.shared = client
        /*
         1. Pass the client into the constructor (constructor injection)
         2. Pass the client to the property after constructor (property injection)
         3. Pass the client as a function parameter (method/dependency injection)
        */
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
