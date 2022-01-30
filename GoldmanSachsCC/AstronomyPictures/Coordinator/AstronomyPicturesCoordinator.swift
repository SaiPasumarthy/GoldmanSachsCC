//
//  AstronomyPicturesCoordinator.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import UIKit

/**
 This is concrete type of AstronomyPicturesBaseCoordinator
 which starts the pictures list view controller chain
*/
class AstronomyPicturesCoordinator: AstronomyPicturesBaseCoordinator {
    
    lazy var rootViewController: UIViewController = UIViewController()
    private weak var searchAstronomyPictureDelegate: SearchAstronomyPicturesDelegate?
    
    func start() -> UIViewController {
        let astronomyPictureViewController = AstronomyPictureViewController.instantiateFromStoryboard()
        astronomyPictureViewController.coordinator = self
        searchAstronomyPictureDelegate = astronomyPictureViewController
        
        let navigationViewController = UINavigationController(rootViewController: astronomyPictureViewController)
            
        rootViewController = navigationViewController
        return rootViewController
    }
    
    func navigateToSearchScreen() {
        let searchAPViewController = SearchAstronomyPictureViewController.instantiateFromStoryboard()
        searchAPViewController.coordinator = self
        rootViewController.present(searchAPViewController, animated: true, completion: nil)
    }
    
    func dismissSearchScreenWith(startDate: String, endDate: String) {
        searchAstronomyPictureDelegate?.searchAstronomyPictures(from: startDate, to: endDate)
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
