//
//  NoteController.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 22.01.2021.
//

import UIKit

class NoteController: UITableViewController {
    
    var note: Note?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var textDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textName.text = note?.name
        textDescription.text = note?.textDescription
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
     
        if textName.text == "" && textDescription.text == "" {
            CoreDataManager.sharedInstance.managedObjectContext.delete(note!);
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if note?.name != textName.text || note?.textDescription != textDescription.text {
            note?.dateUpdate = Date()
        }
        
        note?.name = textName.text
        note?.textDescription = textDescription.text
        
        CoreDataManager.sharedInstance.saveContext();
    
    }
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    
    //        SOURCETYPE
     //   if !UIImagePickerController.isSourceTypeAvailable(.camera) {
    //        print ("no camera!")
   //     } else {
   //         print ("happycam!")
   //     }
     //        CAMERA TYPES
   //     if !UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear){
  //          print ("no rear camera!")
  //      } else {
   //         print ("rear camera available!")
    //    }
   //     if !UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front){
   //         print ("no front camera!")
   //     } else {
    //       print ("front camera available!")//
   //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            
            let alertController = UIAlertController(title: "Choose action for image", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //imagePicker.isCameraDeviceAvailable == true {
                let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default) { (alert) in
                
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                }
                alertController.addAction(a1Camera)
            }
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default) { (alert) in
                
                //self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(a2Photo)
            
            if self.imageView.image != nil {
                let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { (alert) in
                    self.imageView.image = nil
                }
                alertController.addAction(a3Delete)
            }
            
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alert) in
                
            }
            alertController.addAction(a4Cancel)
            
            
            present(alertController, animated: true, completion: nil)
            
            
        }
    }

    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
    //    // #warning Incomplete implementation, return the number of sections
   //     return 0
    //}

   // override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //     // #warning Incomplete implementation, return the number of rows
  //      return 0
   // }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NoteController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
