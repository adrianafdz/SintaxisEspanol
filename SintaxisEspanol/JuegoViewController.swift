//
//  JuegoViewController.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/10/21.
//

import UIKit

class JuegoViewController: UIViewController {

    @IBOutlet weak var btnComa: UIButton!
    @IBOutlet weak var btnRevisar: UIButton!
    @IBOutlet weak var lbParte: UILabel!
    
    var sujeto = "Yo"
    var verbo = "leo"
    var predicado = "un libro"
    var curr = 0
    var arrPartes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnComa.isHidden = Configuracion.modo
        
        btnComa.layer.cornerRadius = 5
        btnRevisar.layer.cornerRadius = 5
        lbParte.layer.cornerRadius = 10
        lbParte.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        lbParte.layer.borderWidth = 1
        
        setOracion()
    }
    
    func setOracion() {
        arrPartes = [sujeto, verbo, predicado]
        lbParte.text = arrPartes[0]
    }
    
    @IBAction func nextParte(_ sender: UIButton) {
        if curr == arrPartes.count - 1 {
            curr = 0
        } else {
            curr += 1
        }

        lbParte.text = arrPartes[curr]
    }
    
    
    @IBAction func prevParte(_ sender: UIButton) {
        if curr == 0 {
            curr = arrPartes.count - 1
        } else {
            curr -= 1
        }

        lbParte.text = arrPartes[curr]
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
