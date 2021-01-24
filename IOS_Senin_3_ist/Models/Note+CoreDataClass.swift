//
//  Note+CoreDataClass.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 18.01.2021.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {

    class func newNote(name: String, inFolder: Folder?) -> Note {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        note.name = name;
        note.dateUpdate = Date()
        
        //if let inFolder = inFolder {
            note.folder = inFolder
        //}
        return note
    }
    
    
    var imageActual: UIImage? {
        set {
            if newValue == nil {
                if self.image != nil {
                    CoreDataManager.sharedInstance.managedObjectContext.delete(self.image!)
                }
                self.imageSmall = nil
            } else {
                if self.image == nil {
                    self.image = ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
                }
                self.image?.imageBig = newValue!.jpegData(compressionQuality: 1)
                self.imageSmall = newValue!.jpegData(compressionQuality: 0.05)
            }
            self.dateUpdate = Date()
        }
        
        get {
            if self.image != nil {
                if image?.imageBig != nil {
                    return UIImage(data: self.image!.imageBig!)
                }
            }
            return nil
        }
    }
    
    
    func addImage(image: UIImage)
    {
        let imageNote =  ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        imageNote.imageBig = image.jpegData(compressionQuality: 1)
        
        self.image = imageNote
        
        
    }
    
    func addLocation(latitude: Double, lontitude: Double)
    {
        let location = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        location.lat = latitude
        location.lon = lontitude
        
        self.location = location
    }
    
    var dateUpdateString: String {
        let df = DateFormatter();
        df.dateStyle = .medium
        df.timeStyle = .short
        
        return df.string(from: self.dateUpdate!)
    }
    
}
