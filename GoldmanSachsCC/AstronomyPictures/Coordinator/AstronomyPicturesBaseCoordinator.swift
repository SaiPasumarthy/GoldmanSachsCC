//
//  AstronomyPicturesBaseCoordinator.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/**
 AstronomyPicturesBaseCoordinator is child coordinator
 which communicates between pictures list view controller chain
*/
protocol AstronomyPicturesBaseCoordinator: Coordinator {
    func navigateToSearchScreen()
    func dismissSearchScreenWith(startDate: String, endDate: String)
}
