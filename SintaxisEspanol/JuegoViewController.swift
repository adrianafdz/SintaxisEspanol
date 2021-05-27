//
//  JuegoViewController.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/10/21.
//

import UIKit

class JuegoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {


    @IBOutlet weak var collectionView: UICollectionView!
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
    
    var numPreguntas : Float = 10
    var oracionActual : Oracion!
    var curr = 0
    var arrPartes = [String]()
    var respuesta = [String]()
    
    var respuestas = [[String]]()
    var resultados = [Bool]()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnComa.isHidden = !Configuracion.modo
        
        btnComa.layer.cornerRadius = 5
        btnRevisar.layer.cornerRadius = 5
        btnParte.layer.cornerRadius = 10
        btnParte.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        btnParte.layer.borderWidth = 1
        
        numPreguntas = UserDefaults.standard.float(forKey: "NumPreg")
        
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        setOracion()
        timerActive = true
        startTimer()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func setOracion() {
        // elegir oracion al azar
        oracionActual = listaOraciones[Int.random(in: 0..<listaOraciones.count)]
        arrPartes = oracionActual.getPartesEnDesorden()
        curr = 0
        btnParte.setTitle(arrPartes[curr], for: .normal)
        btnParte.isHidden = false
        respuesta = [String]()
        btnRevisar.isEnabled = false
        btnComa.isEnabled = true
        btnPrev.isHidden = false
        btnNext.isHidden = false
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
        let indexPath = IndexPath(row:respuesta.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
    func toggleCarusel() {
        btnParte.isHidden = !btnParte.isHidden
        btnPrev.isHidden = !btnPrev.isHidden
        btnNext.isHidden = !btnNext.isHidden
        btnRevisar.isEnabled = !btnRevisar.isEnabled
        btnComa.isEnabled = !btnRevisar.isEnabled
    }
    
    @IBAction func seleccionarParte(_ sender: UIButton) {

        respuesta.append(arrPartes[curr])
        arrPartes.remove(at: curr)
        
        let indexPath = IndexPath(row:respuesta.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
 
        if arrPartes.count == 0 {
            toggleCarusel()
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
        
        progreso.progress += Float(1/numPreguntas)
        if timerActive {
            timer.invalidate()
            
//            respuesta.removeAll()
//            collectionView.reloadData()
            timerActive = !timerActive
        }
    }
    
    func siguientePregunta() {
		if progreso.progress == 1.0 {
			performSegue(withIdentifier: "resultadosFinales", sender: nil)
			
		} else {
			respuesta.removeAll()
			collectionView.reloadData()
			
			timerActive = true
			setOracion()
			startTimer()
		}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vistaPop = segue.destination as? ResultadoPopOver {
			let revision = oracionActual.revisar(respuesta: respuesta)
			
			let resultado = revision.0
			let feedback = revision.1
			
            respuestas.append(respuesta)
            resultados.append(resultado)
            
            vistaPop.resultado = resultado
			vistaPop.feedback = feedback
            vistaPop.popoverPresentationController?.delegate = self
				
            
        } else if let vista = segue.destination as? ViewControllerResultadosFinales{
            vista.respuestas = respuestas
            vista.resultados = resultados
            vista.tiempo = count
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        if progreso.progress == 1.0 {
			performSegue(withIdentifier: "resultadosFinales", sender: nil)
            
        } else {
            siguientePregunta()
        }
    }
    
    @objc func updateTimer() {
        count += 1
        // update label
        var strTime = String(format: "%02d", count/60)
        strTime += ":" + String(format: "%02d", count%60)
        lbTime.text = strTime
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        respuesta.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! TarjetaCollectionViewCell
        
        cell.configure(with: respuesta[indexPath.row])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 5
        cell.layer.backgroundColor = CGColor(red: 185/255, green: 196/255, blue: 213/255, alpha: 1)
        cell.maxWidth = collectionView.bounds.width - 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let parte = respuesta[indexPath.row]
        
        respuesta.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        
        if parte != "," {
            if arrPartes.count == 0 {
                btnParte.setTitle(parte, for: .normal)
                toggleCarusel()
            }
                
            arrPartes.append(parte)
        }
    }
    
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approxWidth = collectionView.bounds.width - 20
        let size = CGSize(width: approxWidth, height: 1000)

        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        let estimateFrame = NSString(string: respuesta[indexPath.row]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset

        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                    - sectionInset.left
                    - sectionInset.right
                    - collectionView.contentInset.left
                    - collectionView.contentInset.right
        
        return CGSize(width: referenceWidth, height: estimateFrame.height)
    }
    
    
}
