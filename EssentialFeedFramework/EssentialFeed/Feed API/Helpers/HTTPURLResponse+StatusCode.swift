//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 23/04/2025.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOk: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
