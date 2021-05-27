//
//  ViewController.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/10/21.
//

import UIKit

struct Configuracion {
    // false sin comas, true con
    static var modo = false
    static var numPreg = 5
}

var listaOraciones = [Oracion]()

class ViewController: UIViewController {

    @IBOutlet weak var btnComenzar: UIButton!
    @IBOutlet weak var btnModo: UIButton!
    @IBOutlet weak var btnHistorial: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnComenzar.layer.cornerRadius = 5
        btnModo.layer.cornerRadius = 5
        btnHistorial.layer.cornerRadius = 5
        
        btnModo.layer.borderWidth = 1
        btnModo.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        btnHistorial.layer.borderWidth = 1
        btnHistorial.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        // Configuración
        let defaults = UserDefaults.standard
        
        Configuracion.modo = defaults.bool(forKey: "Modo")
        Configuracion.numPreg = defaults.integer(forKey: "NumPreg")
        
        btnModo.setTitle(Configuracion.modo ? "Con comas" : "Sin comas", for: .normal)
        
        // Cargar oraciones
        let ruta = Bundle.main.path(forResource: "oraciones", ofType: "json")!
        
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: ruta))
            listaOraciones = try JSONDecoder().decode([Oracion].self, from: data)
        } catch {
            print("Error al cargar archivo")
        }
        //print path
        print(FileManager.getDocumentsDirectory())
    }

    @IBAction func toggleModo(_ sender: UIButton) {
        Configuracion.modo = !Configuracion.modo
        btnModo.setTitle(Configuracion.modo ? "Con comas" : "Sin comas", for: .normal)
    }
    
    @IBAction func unwindConfig(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let defaults = UserDefaults.standard
        Configuracion.numPreg = defaults.integer(forKey: "NumPreg")
    }
    
}
