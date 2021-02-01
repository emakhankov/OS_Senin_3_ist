//
//  NoteCell.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 01.02.2021.
//

import UIKit



class NoteCell: UITableViewCell {

    var note: Note?
    
    @IBOutlet weak var imageNote: UIImageView!
    
    @IBOutlet weak var labelNameNote: UILabel!
    
    @IBOutlet weak var labelDateUpdate: UILabel!
    
    @IBOutlet weak var labelLocation: UILabel!
    
    func initCell(note: Note)
    {
        self.note = note
        
        if note.imageSmall != nil {
            imageNote.image = UIImage(data: note.imageSmall!)
        } else {
            imageNote.image = UIImage(named: "Zaglushka.png")
        }
        labelNameNote.text = note.name
        labelDateUpdate.text = note.dateUpdateString
        if let _ = note.location {
            labelLocation.text = "Location"
        }  else {
            labelLocation.text = ""
        }
        
        //imageNote.layer.cornerRadius = 10
        imageNote.layer.cornerRadius = imageNote.frame.width / 2
        imageNote.layer.masksToBounds = true

        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
