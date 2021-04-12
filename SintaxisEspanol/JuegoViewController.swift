//
//  JuegoViewController.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/10/21.
//

import UIKit

class JuegoViewController: UIViewController {

    @IBOutlet weak var lbTime: UILabel!
    var timer : Timer!
    var count : Int = 0
    var timerActive = false
    
    @IBOutlet weak var progreso: UIProgressView!
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
        timerActive = true
        startTimer()
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
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func revisar(_ sender: UIButton) {
        if timerActive {
            timer.invalidate()
            btnRevisar.setTitle("Continuar", for: .normal)
        } else {
            startTimer()
            btnRevisar.setTitle("Revisar", for: .normal)
        }
        
        timerActive = !timerActive
        progreso.progress += 0.2
        
        if progreso.progress == 1 {
            print("done")
            let alert = UIAlertController(title: "Fin", message: "Terminaste el quiz", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .default, handler: {_ in 
                self.dismiss(animated: true, completion:nil)
            })
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func updateTimer() {
        count += 1
        // update label
        var strTime = String(format: "%02d", count/60)
        strTime += ":" + String(format: "%02d", count%60)
        lbTime.text = strTime
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
