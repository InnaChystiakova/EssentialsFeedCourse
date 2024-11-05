//
//  LocalFeedImage.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 31/10/2024.
//

import Foundation

public struct LocalFeedImage: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
