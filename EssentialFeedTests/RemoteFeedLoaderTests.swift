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
            HTTPClient.shared.requestedURL = URL(string: "https://a-given-url.com")!
        }
    }
    
    class HTTPClient {
        static let shared = HTTPClient()
        private init() {}
        var requestedURL: URL?
    }

    func testInitDoesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func testLoadRequestDataFromURL() {
        let client = HTTPClient.shared
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
