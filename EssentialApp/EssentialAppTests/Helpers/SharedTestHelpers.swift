//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 31/10/2024.
//

import Foundation
@testable import EssentialFeedFramework

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(),
                      description: "any",
                      location: "any",
                      url: URL(string: "http//any-url.com")!
                     )]
}
