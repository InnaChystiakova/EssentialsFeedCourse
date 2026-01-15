//
//  FeedImageLoaderSpy.swift
//  EssentialApp
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import Foundation
import EssentialFeedFramework

class FeedImageLoaderSpy: FeedImageDataLoader {
    private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    private struct Task : FeedImageDataLoaderTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    var loadedURLs: [URL] { return messages.map { $0.url } }
    var cancelledURLs = [URL]()
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    func complete(with data: Data, at index: Int = 0) {
        messages[index].completion(.success(data))
    }
    
    func complete(with error: NSError, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
}
