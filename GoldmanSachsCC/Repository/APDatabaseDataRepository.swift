//
//  APDataRepository.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 29/01/22.
//

import Foundation
import CoreData

/**
    This struct is concrete type of  APDatabaseRepository
    which will implement to fetch the
    Astronomy Pictures from the database
*/
struct APDatabaseDataRepository: APDatabaseRepository {
    func getFavoriteAstronomyPictures(completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void) {
        let fetchRequest = NSFetchRequest<CDAstronomyPicture>(entityName: "CDAstronomyPicture")
        let predicate = NSPredicate(format: "favorite == YES")
        let sortDesc = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDesc]
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            convertCDAstronomyPicturesToAstronomyPictures(result: result, completionHandler: completionHandler)
        } catch let error {
            completionHandler(nil, ErrorResponse(code: 400, msg: error.localizedDescription, service_version: "v1"))
        }
    }
    
    func getAstronomyPictures(from startDate: String, to endDate: String, completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void) {        
        let fetchRequest = NSFetchRequest<CDAstronomyPicture>(entityName: "CDAstronomyPicture")
        let sortDesc = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDesc]
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            convertCDAstronomyPicturesToAstronomyPictures(result: result, completionHandler: completionHandler)
        } catch let error {
            completionHandler(nil, ErrorResponse(code: 400, msg: error.localizedDescription, service_version: "v1"))
        }
    }
    
    func insertAstronomyPictures(records: [AstronomyPicture]) {
        
        PersistentStorage.shared.context.automaticallyMergesChangesFromParent = true
        
        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            privateManagedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            records.forEach { astronomyPicture in
                
                let fetchRequest = NSFetchRequest<CDAstronomyPicture>(entityName: "CDAstronomyPicture")
                let predicate = NSPredicate(format: "date == %@", astronomyPicture.date.getDateForString()! as CVarArg)
                fetchRequest.predicate = predicate
                do {
                    let result = try privateManagedContext.fetch(fetchRequest)
                    if result.count == 0 {
                        let cdAstronomyPicture = CDAstronomyPicture(context: privateManagedContext)
                        cdAstronomyPicture.copyright = astronomyPicture.copyright
                        cdAstronomyPicture.date = astronomyPicture.date.getDateForString()!
                        cdAstronomyPicture.explanation = astronomyPicture.explanation
                        cdAstronomyPicture.title = astronomyPicture.title
                        cdAstronomyPicture.hdurl = astronomyPicture.hdurl
                        cdAstronomyPicture.url = astronomyPicture.url
                        cdAstronomyPicture.media_type = astronomyPicture.media_type
                        cdAstronomyPicture.service_version = astronomyPicture.service_version
                        cdAstronomyPicture.favorite = false
                    }
                } catch {
                }
            }
            
            if privateManagedContext.hasChanges {
                try? privateManagedContext.save()
            }
        }        
    }
    
    private func convertCDAstronomyPicturesToAstronomyPictures(result: [CDAstronomyPicture], completionHandler: @escaping (Array<AstronomyPicture>?, ErrorResponse?) -> Void) {
        var pictures = [AstronomyPicture]()
        result.forEach({ (cdAstronomyPicture) in
            pictures.append(cdAstronomyPicture.convertToAstronomyPicture())
        })
        
        completionHandler(pictures, nil)
    }
}


