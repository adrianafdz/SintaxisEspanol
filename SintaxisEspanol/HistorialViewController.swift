//
//  HistorialViewController.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 21/04/21.
//

import UIKit

class HistorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    
    @IBOutlet weak var tableView: UITableView!
    var listaDeScores = [ Score(fecha: "01/01/2021", tiempo: "1:06", puntaje: "6/6", conComa: true),Score(fecha: "02/02/2021", tiempo: "00:56", puntaje: "5/6", conComa: false)]
    
    var Coma: Bool!
    var p: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HighscoreCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "highscoreCell")
        Coma = false
        p = 0
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeScores.filter{$0.conComa == Coma}.count

    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreCell") as! HighscoreCell
        cell.customInit(fecha: listaDeScores[indexPath.row].fecha, tiempo: listaDeScores[indexPath.row].tiempo, Puntaje: listaDeScores[indexPath.row].puntaje)
        return cell
    }
  
    @IBAction func SwitchTableView(_ sender: UISegmentedControl) {
        p = sender.selectedSegmentIndex
        if(p == 0){
            Coma = false
        }
        if(p == 1){
            Coma = true
        }
        tableView.reloadData()
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
