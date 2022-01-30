//
//  APBaseRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/**
    This protocol represents to fetch the
     Astronomy Pictures from the database or JSON API
*/
protocol APBaseRepository {
    func getAstronomyPictures(from startDate: String, to endDate: String, completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void)
}
