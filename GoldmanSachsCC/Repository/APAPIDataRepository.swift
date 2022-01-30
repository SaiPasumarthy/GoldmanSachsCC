//
//  APAPIDataRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import Alamofire

/**
    This struct is concrete type of  APAPIRepository
    which will implement to fetch the
    Astronomy Pictures from the JSON API
*/
struct APAPIDataRepository: APAPIRepository {
    private let sourceURLString = "https://api.nasa.gov/planetary/apod?api_key=KR9OYWFBCsFYkpz37onrPpnlUp87fXmilG8xzk9x&start_date=%@&end_date=%@"
    
    func getAstronomyPictures(from startDate: String, to endDate: String, completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void) {
        
        AF.request(String(format: sourceURLString, startDate, endDate)).response { response in
            debugPrint(response)
            if let err = response.error {
                completionHandler(nil, ErrorResponse(code: 400, msg: err.localizedDescription, service_version: "v1"))
                return
            }
            
            guard let data = response.data else {
                completionHandler(nil, ErrorResponse(code: 400, msg: "Server data is nil", service_version: "v1"))
                return
            }
                        
            if let successResponse = try? JSONDecoder().decode([AstronomyPicture].self, from: data) {
                completionHandler(successResponse, nil)
            } else if let responseError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                completionHandler(nil, responseError)
            }
        }
    }
}
