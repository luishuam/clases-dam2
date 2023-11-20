//
//  ContactoTableViewCell.swift
//  Cibertec9T6GL
//
//  Created by DAMII on 17/10/23.
//

import UIKit

class ContactoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreApellidosLabel: UILabel!
    
    @IBOutlet weak var telefonoLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
