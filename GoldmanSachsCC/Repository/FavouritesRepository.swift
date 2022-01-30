//
//  FavouritesRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import Foundation

/**
    This protocol represents to fetch the
    favourite Astronomy Pictures from the database
*/
protocol FavouritesRepository {
    func addToFavourites(astronomyPicture: AstronomyPicture) -> Bool
    func removeFromFavourites(astronomyPicture: AstronomyPicture) -> Bool
}
