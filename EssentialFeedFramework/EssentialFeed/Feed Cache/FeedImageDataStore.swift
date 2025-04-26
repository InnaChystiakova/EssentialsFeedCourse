//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 26/04/2025.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
