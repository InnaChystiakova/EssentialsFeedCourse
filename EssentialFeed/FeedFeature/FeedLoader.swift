//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 06/08/2024.
//

import Foundation

// Protocol that can be used by everyone to implement load function and return equitable result with success or failure with any Error

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult)-> Void)
}
