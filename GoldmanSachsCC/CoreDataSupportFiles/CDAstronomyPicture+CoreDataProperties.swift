//
//  CDAstronomyPicture+CoreDataProperties.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//
//

import Foundation
import CoreData


extension CDAstronomyPicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAstronomyPicture> {
        return NSFetchRequest<CDAstronomyPicture>(entityName: "CDAstronomyPicture")
    }

    @NSManaged public var copyright: String?
    @NSManaged public var date: Date
    @NSManaged public var explanation: String
    @NSManaged public var hdurl: String?
    @NSManaged public var media_type: String
    @NSManaged public var service_version: String
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var favorite: Bool
    
    func convertToAstronomyPicture() -> AstronomyPicture {
        return AstronomyPicture(date: self.date.getStringForDate(), explanation: self.explanation, media_type: self.media_type, service_version: self.service_version, title: self.title, url: self.url, copyright: self.copyright, hdurl: self.hdurl, favourite: self.favorite)
    }

}

extension CDAstronomyPicture : Identifiable {

}
