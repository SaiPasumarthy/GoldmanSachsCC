//
//  AstronomyPicture.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation

/**
    This is the Model of received JSON API for sucess
*/
struct AstronomyPicture: Decodable {
    let date: String
    let explanation, media_type, service_version, title, url: String
    let copyright, hdurl: String?
    var favourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case date, explanation, media_type, service_version, title, url, copyright, hdurl
    }
}

/**
    This is the Model of received JSON API for error
*/
struct ErrorResponse: Decodable {
    let code: Int
    let msg: String
    let service_version: String
}
