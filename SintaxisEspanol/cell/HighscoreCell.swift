//
//  HighscoreCell.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 21/04/21.
//

import UIKit

class HighscoreCell: UITableViewCell {

    @IBOutlet weak var lbFecha: UILabel!
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var lbPuntaje: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func customInit(fecha : String, tiempo : String, Puntaje : String){
        self.lbFecha.text = fecha
        self.lbTiempo.text = tiempo
        self.lbPuntaje.text = Puntaje
    }
    
}
