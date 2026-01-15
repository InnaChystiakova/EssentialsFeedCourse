//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 15/01/2026.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}
