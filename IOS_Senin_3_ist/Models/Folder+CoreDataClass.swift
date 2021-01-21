//
//  Folder+CoreDataClass.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 18.01.2021.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {

    class func newFolder(name: String) -> Folder {
        let folder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        folder.name = name;
        folder.dataUpdate = Date();
        return folder
    }
    
    func newNote() -> Note {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        note.folder = self;
        note.dateUpdate = Date()
        return note
    }
    
    var notesSorted: [Note] {
        let sortDescriptor = NSSortDescriptor(key: "dateUpdate", ascending: false)
        return self.notes?.sortedArray(using: [sortDescriptor]) as! [Note]
    }
    
}
