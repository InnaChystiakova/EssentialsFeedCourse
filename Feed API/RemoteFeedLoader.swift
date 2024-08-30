//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

// we implement the FeedLoader protocol to load FeedItems
// for this task we have url to go and a client to load items (these can be mocked by Spy in the tests)
// we implement other abstract class (client protocol) for this purpose
// and the func load is totaly covered by tests with th get() function from the client
// also we implement here our type of Errors that conforms to Swift.Error
// the result type also conforms to the abstract class (protocol)

public final class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in         // Step 2: move from property to a method invoke
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(RemoteFeedLoader.Error.connectivity))
            }
        }
    }
}
