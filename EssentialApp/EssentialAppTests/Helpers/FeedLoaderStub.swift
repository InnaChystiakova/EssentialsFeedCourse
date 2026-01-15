//
//  FeedLoaderStub.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import EssentialFeedFramework

class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}
