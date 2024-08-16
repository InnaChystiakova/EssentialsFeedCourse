//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public protocol HTTPClient {
    // Step 1: not a singleton anymore
    // Step 5: remove rpivate initializer, since it is not a singleton anymore
    // Step 2: assign a parameter instead of a singleton property
    
    func get(from url: URL, completion: @escaping (Error) -> Void)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void = { _ in }) {
        client.get(from: url) { error in         // Step 2: move from property to a method invoke
            completion(.connectivity)
        }
    }
}

