//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 31/10/2024.
//

import Foundation

//  structure that duplicates the Entity

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL                  // keep the name as in the original JSON key
}
