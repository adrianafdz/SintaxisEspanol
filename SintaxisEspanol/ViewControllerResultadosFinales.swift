//
//  ViewControllerResultadosFinales.swift
//  SintaxisEspanol
//
//  Created by Jair Antonio on 16/05/21.
//

import UIKit

class ViewControllerResultadosFinales: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lb_respuestas: UILabel!
    @IBOutlet weak var lb_tiempo: UILabel!
    @IBOutlet weak var lb_puntuacion: UILabel!
    
    var respuestas = [[String]]()
    var resultados = [Bool]()
    var tiempo = 0
    var puntos : String!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var correctas = 0
        puntos = String(correctas * tiempo)
        for resultado in resultados {
            correctas += resultado ? 1 : 0
        }
        
        lb_respuestas.text = String(correctas)
        lb_tiempo.text = String(tiempo)
        lb_puntuacion.text = String(correctas * tiempo)
    }
	
    func SaveHighscore(){
        
            let hoy = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            let dateT = formatter.string(from: hoy)
            let score = Score(fecha: dateT , tiempo: String(tiempo), puntaje: puntos , conComa: Configuracion.modo)
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let ruta = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("HighScore.plist")
            do{
                let data = try encoder.encode(score)
                try data.write(to: ruta)
                print("saved score")
            }
            catch{
                print(error)
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respuestas.count
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultado", for: indexPath) as! ResultadoCelda
        let index = indexPath.row
        
        var oracion = ""
        
        for parte in respuestas[index] {
            oracion += parte
			oracion += " "
        }
        
		cell.oracion_resultado.text = oracion
		
		var color: UIColor
		
		if resultados[index] {
			color = UIColor(
				red: 206.0 / 255.0,
				green: 222.0 / 255.0,
				blue: 197.0 / 255.0,
				alpha: 255)
			
		} else {
			color = UIColor(
				red: 242.0 / 255.0,
				green: 201.0 / 255.0,
				blue: 201.0 / 255.0,
				alpha: 255)
		}
		
		cell.backgroundColor = color
        
        return cell
    }

}
