//
//  MapController.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 28.01.2021.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        

        // Do any additional setup after loading the view.
        
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
        
        let newNote = Note.newNote(name: "", inFolder: nil)
        newNote.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
        
        let noteController = storyboard?.instantiateViewController(identifier: "noteSID") as! NoteController
        noteController.note = newNote
        navigationController?.pushViewController(noteController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        
        for note in notes {
            if note.locationActual != nil {
                mapView.addAnnotation(NoteAnnotation(note: note))
            }
        }
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

extension MapController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            DispatchQueue.main.async { // так как обращаемся к элементам интерфейса из потока
                mapView.setCenter(annotation.coordinate, animated: true)
            }
            return nil
        }
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let selectedNote = (view.annotation as! NoteAnnotation).note
        
        let noteController = storyboard?.instantiateViewController(identifier: "noteSID") as! NoteController
        
        noteController.note = selectedNote
        
        navigationController?.pushViewController(noteController, animated: true)
        //present(noteController, animated: true, completion: nil) // Так без навигации
    }
    
    
    
    
}


