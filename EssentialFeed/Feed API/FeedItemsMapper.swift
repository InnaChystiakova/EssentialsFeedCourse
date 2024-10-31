//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 30/08/2024.
//

import Foundation

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [RemoteFeedItem]               // decodes array of items from original JSON
    }
    
    private static var OK_200: Int { return 200 }
    
    // map function overload
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            throw RemoteFeedLoader.Error.invalidData
        }
        return root.items
    }
}
