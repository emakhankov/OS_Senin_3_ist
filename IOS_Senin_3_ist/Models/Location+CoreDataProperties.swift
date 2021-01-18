//
//  Location+CoreDataProperties.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 18.01.2021.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var note: Note?

}

extension Location : Identifiable {

}
