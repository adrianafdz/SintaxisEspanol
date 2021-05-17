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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var correctas = 0
        
        for resultado in resultados {
            correctas += resultado ? 1 : 0
        }
        
        lb_respuestas.text = String(correctas)
        lb_tiempo.text = String(tiempo)
        lb_puntuacion.text = String(correctas * tiempo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respuestas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultado", for: indexPath)
        let index = indexPath.row
        
        var oracion = ""
        
        for parte in respuestas[index] {
            oracion += parte
        }
        
        cell.textLabel?.text = oracion
        
        return cell
    }

}
