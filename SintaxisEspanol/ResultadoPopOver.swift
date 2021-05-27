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
    
    var resultado: Bool!
	var feedback: String!
	var colorFondo: UIColor!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSize(width: 300, height: 200)
        
        if resultado {
            lbResultado.text = "Correcto"
			view.backgroundColor = UIColor(
				red: 206.0 / 255.0,
				green: 222.0 / 255.0,
				blue: 197.0 / 255.0,
				alpha: 255)
			
        } else {
            lbResultado.text = "Incorrecto"
			view.backgroundColor = UIColor(
				red: 242.0 / 255.0,
				green: 201.0 / 255.0,
				blue: 201.0 / 255.0,
				alpha: 255)
        }
		
		lbRespuesta.text = feedback
    }
	
	
	@IBAction func continuar(_ sender: UIButton) {
		let vistanterior = presentingViewController as! JuegoViewController
		dismiss(animated: true, completion: nil)
		vistanterior.siguientePregunta()
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
