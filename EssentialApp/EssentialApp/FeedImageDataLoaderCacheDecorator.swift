//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import Foundation
import EssentialFeedFramework

public class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    private struct Task : FeedImageDataLoaderTask {
        func cancel() { }
    }
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache ) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            completion(result.map { imageData in
                self?.cache.saveIgnoringResult(imageData, for: url)
                return imageData
            })
        }
    }
}

private extension FeedImageDataCache {
    func saveIgnoringResult(_ imageData: Data, for url: URL) {
        save(imageData, for: url) { _ in }
    }
}
