//
//  AstronomyPictureViewModel.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/**
 AstronomyPictureViewModel is view modal of Astronomy Pictures
 which get the input from AstronomyPictureViewController and process the model
 and updates the AstronomyPictureViewController
*/
class AstronomyPictureViewModel {
    private var astronomyPictureDataRepository: APDatabaseRepository
    private var astronomyPictureAPIRepository: APAPIRepository
    private var favouritesRepository: FavouritesDataRepository
    var bindAstronomyPictureVM: (() -> Void) = {}
    var bindErrorResponse: (() -> Void) = {}
    
    private(set) var pictureArray: [AstronomyPicture]! {
        didSet {
            self.bindAstronomyPictureVM()
        }
    }
    
    private(set) var errorResponse: ErrorResponse! {
        didSet {
            self.bindErrorResponse()
        }
    }
    
    init() {
        astronomyPictureDataRepository = APDatabaseDataRepository()
        astronomyPictureAPIRepository = APAPIDataRepository()
        favouritesRepository = FavouritesDataRepository()
    }
}

extension AstronomyPictureViewModel {
    func getAstronomyPictureOfTheDay() {
        getAstronomyPicturesBetween(from: Date().getCurrentDateStringOfNASA(), to: Date().getCurrentDateStringOfNASA())
    }
    
    func getAstronomyPictures(from startDate: String, to endDate: String) {
        getAstronomyPicturesBetween(from: startDate, to: endDate)
    }
    
    func addToFavourites(astronomyPicture: AstronomyPicture) {
        let result = favouritesRepository.addToFavourites(astronomyPicture: astronomyPicture)
        if result, let index = pictureArray.firstIndex(where: {$0.date == astronomyPicture.date}) {
            pictureArray[index].favourite = true
        }
    }
    
    func removeFromFavourites(astronomyPicture: AstronomyPicture) {
        let result = favouritesRepository.removeFromFavourites(astronomyPicture: astronomyPicture)
        if result, let index = pictureArray.firstIndex(where: {$0.date == astronomyPicture.date}) {
            pictureArray[index].favourite = false
        }
    }
}

private extension AstronomyPictureViewModel {
    
    private func getAstronomyPicturesBetween(from startDate: String, to endDate: String) {
        if Connectivity.isConnectedToInternet {
            astronomyPictureAPIRepository.getAstronomyPictures(from: startDate, to: endDate) { [weak self] astronomyPictures, errorResponse in
                guard let strongSelf = self else {
                   return
                }
                
                if let error = errorResponse {
                    strongSelf.errorResponse = error
                    return
                }
                
                if let result = astronomyPictures {
                    strongSelf.astronomyPictureDataRepository.insertAstronomyPictures(records: result)
                }

                strongSelf.pictureArray = astronomyPictures
            }
        } else {
            astronomyPictureDataRepository.getAstronomyPictures(from: startDate, to: endDate) { [weak self] astronomyPictures, errorResponse in
                
                guard let strongSelf = self else {
                   return
                }
                
                strongSelf.pictureArray = astronomyPictures
            }
        }
    }
}
