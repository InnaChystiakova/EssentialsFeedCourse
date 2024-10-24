//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 30/08/2024.
//

import Foundation

// the protocol to implement different clients that wants to get some data from url and handle the response or error result

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
