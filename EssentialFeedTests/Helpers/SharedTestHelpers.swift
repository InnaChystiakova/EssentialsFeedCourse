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
