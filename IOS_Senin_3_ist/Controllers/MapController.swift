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
        
        

        // Do any additional setup after loading the view.
        
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


