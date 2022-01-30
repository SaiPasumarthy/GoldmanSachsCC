//
//  CoordinatorBoard.swift
//  CoordinatorPattern
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import UIKit

/// This protocol is to instantiate the view controller from the storyboard
protocol CoordinatorBoard: UIViewController {
    static func instantiateFromStoryboard() -> Self
}

extension CoordinatorBoard {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let id = String(describing: self)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
