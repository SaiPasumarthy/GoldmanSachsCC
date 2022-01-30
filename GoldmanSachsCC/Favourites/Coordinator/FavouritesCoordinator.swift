//
//  FavouritesCoordinator.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import UIKit

/**
 This is concrete type of FavoritesBaseCoordinator
 which starts the favourites view controller chain
*/
class FavouritesCoordinator: FavoritesBaseCoordinator {
    
    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        let favouritesViewController = FavouritesViewController.instantiateFromStoryboard()        
        rootViewController = UINavigationController(rootViewController: favouritesViewController)
        return rootViewController
    }
}
