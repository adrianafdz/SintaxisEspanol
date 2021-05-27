//
//  HistorialViewController.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 21/04/21.
//

import UIKit

class HistorialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var listaDeScores = [Score]()
    var Coma: Bool!
    var p: Int!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerScores()
        let nib = UINib(nibName: "HighscoreCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "highscoreCell")
        Coma = false
        p = 0
        // Do any additional setup after loading the view.
    }
    
     private func obtenerScores(){
        do{
            listaDeScores = try PersistenceHelper.loadScores()
        } catch {
            print("error obtener scores")
        }
    }
    
    private func deleteScore(indexPath: IndexPath){
        do {
            try PersistenceHelper.delete(score: indexPath.row)
        } catch {
            print("error borrar")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeScores.filter{$0.conComa == Coma}.count

    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filteredScores = listaDeScores.filter{$0.conComa == Coma}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreCell") as! HighscoreCell
        
            cell.customInit(fecha: filteredScores[indexPath.row].fecha, tiempo: filteredScores[indexPath.row].tiempo, Puntaje: filteredScores[indexPath.row].puntaje)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle{
        case .delete:
            print("delete")
            listaDeScores.remove(at: indexPath.row)
            deleteScore(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            print("insert")
        default:
            print(".")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
