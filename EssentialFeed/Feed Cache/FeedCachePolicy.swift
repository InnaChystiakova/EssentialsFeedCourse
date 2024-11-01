//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 01/11/2024.
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    
    private static let calendar = Calendar(identifier: .gregorian)

    private static var maxCaheAgeInDays: Int {
        return 7
    }
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCaheAgeInDays, to: timestamp) else { return false }
        return date < maxCacheAge
    }
}
