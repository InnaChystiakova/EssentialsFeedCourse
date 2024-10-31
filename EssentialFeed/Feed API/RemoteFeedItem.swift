//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 31/10/2024.
//

import Foundation

// internal structure that duplicates the Entity

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL                  // keep the name as in the original JSON key
}
