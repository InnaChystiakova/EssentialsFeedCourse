//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 20/04/2025.
//

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
