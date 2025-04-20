//
//  UIRefreshControl+Helpers.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 20/04/2025.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
