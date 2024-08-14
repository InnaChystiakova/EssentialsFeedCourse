//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)        // Step 2: move from property to a method invoke
    }
}

public protocol HTTPClient {
    // Step 1: not a singleton anymore
    // Step 5: remove rpivate initializer, since it is not a singleton anymore
    // Step 2: assign a parameter instead of a singleton property
    
    func get(from url: URL)
}
