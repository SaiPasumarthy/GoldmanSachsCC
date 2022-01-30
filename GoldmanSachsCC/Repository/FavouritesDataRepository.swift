//
//  FavouritesDataRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation
import CoreData

/**
    This struct is concrete type of  FavouritesRepository
    which will implement to fetch the
    favourite Astronomy Pictures from the database
*/
struct FavouritesDataRepository: FavouritesRepository {
    func addToFavourites(astronomyPicture: AstronomyPicture) -> Bool {
     
        let cdAstronomyPicture = CDAstronomyPicture(context: PersistentStorage.shared.context)
        cdAstronomyPicture.copyright = astronomyPicture.copyright
        cdAstronomyPicture.date = astronomyPicture.date.getDateForString()!
        cdAstronomyPicture.explanation = astronomyPicture.explanation
        cdAstronomyPicture.title = astronomyPicture.title
        cdAstronomyPicture.hdurl = astronomyPicture.hdurl
        cdAstronomyPicture.url = astronomyPicture.url
        cdAstronomyPicture.media_type = astronomyPicture.media_type
        cdAstronomyPicture.service_version = astronomyPicture.service_version
        cdAstronomyPicture.favorite = true
        PersistentStorage.shared.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try PersistentStorage.shared.context.save()
            return true
        }
        catch let error {
            print("Add to favourites error : \(error.localizedDescription)")
            return false
        }
    }
    
    func removeFromFavourites(astronomyPicture: AstronomyPicture) -> Bool {
        
        let cdAstronomyPicture = CDAstronomyPicture(context: PersistentStorage.shared.context)
        cdAstronomyPicture.copyright = astronomyPicture.copyright
        cdAstronomyPicture.date = astronomyPicture.date.getDateForString()!
        cdAstronomyPicture.explanation = astronomyPicture.explanation
        cdAstronomyPicture.title = astronomyPicture.title
        cdAstronomyPicture.hdurl = astronomyPicture.hdurl
        cdAstronomyPicture.url = astronomyPicture.url
        cdAstronomyPicture.media_type = astronomyPicture.media_type
        cdAstronomyPicture.service_version = astronomyPicture.service_version
        cdAstronomyPicture.favorite = false
        PersistentStorage.shared.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        do {
            try PersistentStorage.shared.context.save()
            return true
        }
        catch let error {
            print("Add to favourites error : \(error.localizedDescription)")
            return false
        }
    }
}
