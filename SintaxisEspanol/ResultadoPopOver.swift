//
//  ResultadoPopOver.swift
//  SintaxisEspanol
//
//  Created by user188711 on 5/4/21.
//

import UIKit

class ResultadoPopOver: UIViewController {

    @IBOutlet weak var lbResultado: UILabel!
    @IBOutlet weak var lbRespuesta: UILabel!
    
    var oracion : Oracion!
    var resultado : Bool!
    var respuesta : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSize(width: 300, height: 200)
        
        resultado = oracion.revisarSinComas(respuesta: respuesta)
        
        if resultado {
            lbResultado.text = "Correcto"
            lbResultado.tintColor = UIColor.green
        } else {
            lbResultado.text = "Incorrecto"
            lbResultado.tintColor = UIColor.red
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
    
    @IBAction func continuar(_ sender: UIButton) {
        let vistaInicial = presentingViewController as! JuegoViewController
        vistaInicial.siguientePregunta()
        dismiss(animated: true, completion: nil)
    }
    
}