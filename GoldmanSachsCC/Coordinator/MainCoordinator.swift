//
//  MainCoordinator.swift
//  CoordinatorPattern
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import UIKit

/// This is main coordinator which manages child coordinates
class MainCoordinator: MainBaseCoordinator {
    var astronomyPicturesCoordinator: AstronomyPicturesBaseCoordinator = AstronomyPicturesCoordinator()
    var favoritesCoordinator: FavoritesBaseCoordinator = FavouritesCoordinator()
    var rootViewController: UIViewController = UITabBarController()
    
    /// This is starting point of the application to load view controller
    func start() -> UIViewController {
        let astronomyPicturesViewController = astronomyPicturesCoordinator.start()
        astronomyPicturesViewController.tabBarItem = UITabBarItem(title: "Pictures", image: UIImage(named: "Pictures"), tag: 0)
        let favouritesViewController = favoritesCoordinator.start()
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(named: "FavouriteFilled"), tag: 1)
        (rootViewController as? UITabBarController)?.viewControllers = [astronomyPicturesViewController,favouritesViewController]

        return rootViewController
    }
    
}
