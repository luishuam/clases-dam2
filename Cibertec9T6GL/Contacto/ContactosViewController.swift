//
//  ContactosViewController.swift
//  Cibertec9T6GL
//
//  Created by DAMII on 17/10/23.
//

import UIKit

//START SEMANA 12
import CoreData
//END SEMANA 12

struct Contacto {
    var nombre: String
    var telefono: Int
}

class ContactosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactosTableView: UITableView!
    var contactosList: [Contacto] = []
    
    //START SEMANA 12
    var contactoEntidadList : [ContactoEntity] = []
    //END SEMANA 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactosTableView.dataSource = self
        
        //START-semana12:
        //UITableViewDelegate
        contactosTableView.delegate = self
        
        listarContactos()
        //END-semana12:
        
            //contactosList.append(Contacto(nombre: "Victor Egas", telefono: 987987987))
            //contactosList.append(Contacto(nombre: "Grecia Huarote", telefono: 951951951))
        // Do any additional setup after loading the view.
    }
  
    //START-semana11:
    @IBAction func abrirAlertaRegistro(_ sender: Any) {
        
        var nombreTextField = UITextField()
        var telefonoTextField = UITextField()
        
        let alerta = UIAlertController(title: "Registrar Contacto", message: "Completa TODOS los datos", preferredStyle: .alert)
        
        alerta.addTextField {
            alertTextField in alertTextField.placeholder = "Ingrese Nombre"
            nombreTextField = alertTextField
        }
        alerta.addTextField {
            alertTextField in alertTextField.placeholder = "Ingrese Teléfono"
            telefonoTextField = alertTextField
        }
        
        let action = UIAlertAction(title: "Registrar", style: .default, handler: {
            action in
            let nombre = nombreTextField.text
            let telefono = telefonoTextField.text
            self.RegistrarContacto(nombre: nombre, numero: telefono)
        })
        
        alerta.addAction(action)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    //END-semana11:
        
    // Número de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactoEntidadList.count
        // START-semana12:
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactoCell", for: indexPath) as! ContactoTableViewCell
        let contacto = contactoEntidadList[indexPath.row] //        //START-semana12:
        cell.nombreApellidosLabel.text = contacto.nombre
        cell.telefonoLabel.text = contacto.numero //       Se creo como string numero //START-semana12:
        
        return cell
    }
    
    //START-semana13:
    //selecciona data con tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contacto = contactoEntidadList[indexPath.row]
        print("")
        print(contacto.nombre ?? "")
        print(contacto.numero ?? "")
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContactoDetalleViewController") as! ContactoDetalleViewController
        vc.nombre = contacto.nombre ?? ""
        vc.telefono = contacto.numero ?? ""
        
        // pop up // self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //END-semana13:
    
    
    
    //START-semana11:
    func RegistrarContacto(nombre: String?, numero: String?) {
        if let name = nombre, let phone = numero {
            /*
             let contacto = Contacto(nombre: name, telefono: Int(phone) ?? 0)
             contactosList.append(contacto)
             contactosTableView.reloadData()
             */
            //START-semana12:
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entidad = ContactoEntity(context: managedContext)
            entidad.nombre = name
            entidad.numero = phone
            
            do {
                try managedContext.save()
                contactoEntidadList.append(entidad)
            }
            catch let error as NSError {
                print("No fue posible guardar los datos \(error), \(error.userInfo)")
            }
            contactosTableView.reloadData()
        }
    }
    
    func listarContactos(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let results = try managedContext.fetch(ContactoEntity.fetchRequest())
            contactoEntidadList = results as! [ContactoEntity]
        }
        catch let error as NSError {
            print("No fue posible guardar los datos \(error), \(error.userInfo)")
        }
        contactosTableView.reloadData()
    }
    
    //END-semana11:
}
