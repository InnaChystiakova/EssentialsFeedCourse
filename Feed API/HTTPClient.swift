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
    // Step 1: not a singleton anymore
    // Step 5: remove rpivate initializer, since it is not a singleton anymore
    // Step 2: assign a parameter instead of a singleton property
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
