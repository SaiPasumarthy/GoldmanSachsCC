//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import UIKit

/// This is main coordinator which starts the application with rootviewcontroller
protocol Coordinator: AnyObject {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
}









