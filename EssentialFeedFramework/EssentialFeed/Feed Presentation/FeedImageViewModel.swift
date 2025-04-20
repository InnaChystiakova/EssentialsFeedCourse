//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 20/04/2025.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}
