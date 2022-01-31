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
        convertAstronomyPicture(isFavourite: true, astronomyPicture: astronomyPicture)
        PersistentStorage.shared.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try PersistentStorage.shared.context.save()
            return true
        }
        catch {
            return false
        }
    }
    
    func removeFromFavourites(astronomyPicture: AstronomyPicture) -> Bool {
        convertAstronomyPicture(astronomyPicture: astronomyPicture)
        PersistentStorage.shared.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        do {
            try PersistentStorage.shared.context.save()
            return true
        }
        catch {
            return false
        }
    }
}

private extension FavouritesDataRepository {
    func convertAstronomyPicture(isFavourite: Bool = false, astronomyPicture: AstronomyPicture) {
        let cdAstronomyPicture = CDAstronomyPicture(context: PersistentStorage.shared.context)
        cdAstronomyPicture.copyright = astronomyPicture.copyright
        cdAstronomyPicture.date = astronomyPicture.date.getDateForString()!
        cdAstronomyPicture.explanation = astronomyPicture.explanation
        cdAstronomyPicture.title = astronomyPicture.title
        cdAstronomyPicture.hdurl = astronomyPicture.hdurl
        cdAstronomyPicture.url = astronomyPicture.url
        cdAstronomyPicture.media_type = astronomyPicture.media_type
        cdAstronomyPicture.service_version = astronomyPicture.service_version
        cdAstronomyPicture.favorite = isFavourite
    }
}
