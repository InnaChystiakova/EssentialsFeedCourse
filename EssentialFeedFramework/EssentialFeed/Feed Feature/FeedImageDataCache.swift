//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
