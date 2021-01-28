//
//  NoteMapController.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 27.01.2021.
//

import UIKit
import MapKit

class NoteAnnotation: NSObject, MKAnnotation {
    
    var note: Note
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String?

    var subtitle: String?
    
    init(note: Note) {
        
        self.note = note
        title = note.name
        
        if note.locationActual != nil {
            coordinate = CLLocationCoordinate2D(latitude: note.locationActual!.lat, longitude: note.locationActual!.lon)
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
}


class NoteMapController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        //print(note?.locationActual)
        if note?.locationActual != nil {
            
            
            let na = NoteAnnotation(note: note!)
            mapView.addAnnotation(na)
            
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: note!.locationActual!.lat, longitude: note!.locationActual!.lon)
            
            
        }
        
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLongTap(recognizer: UIGestureRecognizer) {
        if recognizer.state != .began {
            return
        }
        let point = recognizer.location(in: mapView)
        let c = mapView.convert(point, toCoordinateFrom: mapView)
        note?.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
        CoreDataManager.sharedInstance.saveContext()
        
        mapView.removeAnnotations(mapView.annotations)
        
        let na = NoteAnnotation(note: note!)
        mapView.addAnnotation(na)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteMapController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        
        pin.isDraggable = true
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
       
        //print("Поменяли положение")
        
        if newState == .ending {
            
            //print("EDIT")
            let newLocation = LocationCoordinate(lat: (view.annotation?.coordinate.latitude)!, lon: (view.annotation?.coordinate.longitude)!)
            note?.locationActual = newLocation
            CoreDataManager.sharedInstance.saveContext()
            
        }
    }
    
    
}

