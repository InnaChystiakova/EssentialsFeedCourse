//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 06/08/2024.
//

import Foundation

// Protocol that can be used by everyone to implement load function and return equitable result with success or failure with any Error

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping(LoadFeedResult<Error>)-> Void)
}
