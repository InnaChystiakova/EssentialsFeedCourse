//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 30/08/2024.
//

import Foundation

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [Item]               // decodes array of items from original JSON
        
        var feed: [FeedItem] {
            return items.map { $0.item }        // takes array of items, prepared from JSON, and maps them into array of Entity items
        }
    }

    // private structure that duplicates the Entity
    
    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL                  // keep the name as in the original JSON key
        
        // convert to the high level struct (Entity), where original keys are semantically clear
        // returns the Entity item, created with passed data
        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    // map function overload
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        return .success(root.feed)
    }
}
