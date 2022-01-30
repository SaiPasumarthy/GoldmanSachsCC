//
//  APDatabaseRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/**
    This protocol represents to fetch the
    Astronomy Pictures from the database
*/
protocol APDatabaseRepository: APBaseRepository {
    func insertAstronomyPictures(records: [AstronomyPicture])
    func getFavoriteAstronomyPictures(completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void)
}
