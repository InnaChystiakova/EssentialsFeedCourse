//
//  UITableView+Dequeueing.swift
//  EssentialFeed
//
//  Created by Inna Chystiakova on 11/04/2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
