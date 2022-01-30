//
//  FavouritesViewModel.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation

/**
 FavouritesViewModel is view modal of Favourites
 which get the input from FavouritesViewController and process the model
 and updates the FavouritesViewController
*/
class FavouritesViewModel {
    private var astronomyPictureDataRepository: APDatabaseRepository
    private var favouritesRepository: FavouritesDataRepository
    var bindFavouritesVM: (() -> Void) = {}

    private(set) var favouritesArray: [AstronomyPicture]! {
        didSet {
            self.bindFavouritesVM()
        }
    }
    
    init() {
        astronomyPictureDataRepository = APDatabaseDataRepository()
        favouritesRepository = FavouritesDataRepository()
    }
    
    func getFavouritePictures() {
        astronomyPictureDataRepository.getFavoriteAstronomyPictures { [weak self] favouritePictures, errorResponse in
            guard let strongSelf = self else { return }
            guard let favouritesPictures = favouritePictures else { return }
            strongSelf.favouritesArray = favouritesPictures
        }
    }
    
    func removeFromFavourites(astronomyPicture: AstronomyPicture) {
        let result = favouritesRepository.removeFromFavourites(astronomyPicture: astronomyPicture)
        if result, let index = favouritesArray.firstIndex(where: {$0.date == astronomyPicture.date}) {
            favouritesArray.remove(at: index)
        }
    }
}
