//
//  ImageNote+CoreDataProperties.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 18.01.2021.
//
//

import Foundation
import CoreData


extension ImageNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageNote> {
        return NSFetchRequest<ImageNote>(entityName: "ImageNote")
    }

    @NSManaged public var imageBig: Data?
    @NSManaged public var note: Note?

}

extension ImageNote : Identifiable {

}
