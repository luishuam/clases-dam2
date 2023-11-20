//
//  ContactoDetalleViewController.swift
//  Cibertec9T6GL
//
//  Created by DAMII on 14/11/23.
//

import UIKit

class ContactoDetalleViewController: UIViewController {

    
    //invocacion
    
    @IBOutlet weak var nombreContactoLabel: UILabel!
    
    @IBOutlet weak var numeroContactoLabel: UILabel!
    
    
    var nombre:String = ""
    
    var telefono:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nombreContactoLabel.text = nombre
        numeroContactoLabel.text = telefono
    }
    


}
