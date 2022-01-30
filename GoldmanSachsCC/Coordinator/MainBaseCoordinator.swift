//
//  MainBaseCoordinator.swift
//  CoordinatorPattern
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/// This main base coordinator to manage the child coordinators
protocol MainBaseCoordinator: Coordinator {
    var astronomyPicturesCoordinator: AstronomyPicturesBaseCoordinator { get }
    var favoritesCoordinator: FavoritesBaseCoordinator { get }
}

/// This is child coordinator which can communicate to the other view controllers
protocol AstronomyPicturesBaseCoordinated {
    var coordinator: AstronomyPicturesBaseCoordinator? { get }
}

