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
    @IBOutlet weak var btnParte: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    
    // no es lo que se va a ver en realidad, solo para checar
    @IBOutlet weak var lbRespuesta: UILabel!
    var res = ""
    
    var numPreguntas : Float = 10
    var oracionActual : Oracion!
    var curr = 0
    var arrPartes = [String]()
    var respuesta = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnComa.isHidden = Configuracion.modo
        
        btnComa.layer.cornerRadius = 5
        btnRevisar.layer.cornerRadius = 5
        btnParte.layer.cornerRadius = 10
        btnParte.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        btnParte.layer.borderWidth = 1
        
        numPreguntas = UserDefaults.standard.float(forKey: "NumPreg")
        
        setOracion()
        timerActive = true
        startTimer()
    }
    
    func setOracion() {
        // elegir oracion al azar
        oracionActual = listaOraciones[Int.random(in: 0..<listaOraciones.count)]
        arrPartes = oracionActual.getPartes()
        curr = 0
        btnParte.setTitle(arrPartes[curr], for: .normal)
        btnParte.isHidden = false
        respuesta = [String]()
        btnRevisar.isEnabled = false
        btnComa.isEnabled = true
        btnPrev.isHidden = false
        btnNext.isHidden = false
        
        res = ""
        lbRespuesta.text = ""
    }
    
    @IBAction func nextParte(_ sender: UIButton) {
        if curr == arrPartes.count - 1 {
            curr = 0
        } else {
            curr += 1
        }

        btnParte.setTitle(arrPartes[curr], for: .normal)
    }
    
    @IBAction func prevParte(_ sender: UIButton) {
        if curr == 0 {
            curr = arrPartes.count - 1
        } else {
            curr -= 1
        }

        btnParte.setTitle(arrPartes[curr], for: .normal)
    }
    
    @IBAction func agregarComa(_ sender: UIButton) {
        respuesta.append(",")
        
        res += ", "
        lbRespuesta.text = res
    }
    
    @IBAction func seleccionarParte(_ sender: UIButton) {
        
        res += arrPartes[curr] + " "
        lbRespuesta.text = res
        
        respuesta.append(arrPartes[curr])
        arrPartes.remove(at: curr)
        
        if arrPartes.count == 0 {
            btnParte.isHidden = true;
            btnParte.setTitle("", for: .normal)
            btnPrev.isHidden = true
            btnNext.isHidden = true
            btnRevisar.isEnabled = true
            btnComa.isEnabled = false
        } else {
            if curr+1 >= arrPartes.count {
                curr = 0
            } else {
                curr += 1
            }
            btnParte.setTitle(arrPartes[curr], for: .normal)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func revisar(_ sender: UIButton) {
        if timerActive {
            timer.invalidate()
            print(respuesta)
            btnRevisar.setTitle("Continuar", for: .normal)
        } else {
            setOracion()
            startTimer()
            btnRevisar.setTitle("Revisar", for: .normal)
        }
        
        timerActive = !timerActive
        progreso.progress += Float(1/numPreguntas)
        
        if progreso.progress == 1 {
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
