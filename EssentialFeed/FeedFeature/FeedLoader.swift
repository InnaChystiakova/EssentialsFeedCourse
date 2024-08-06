//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 06/08/2024.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult)-> Void)
}
