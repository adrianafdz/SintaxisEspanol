//
//  Score.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 21/04/21.
//

import UIKit

class Score: NSObject , Codable{
    
    var tiempo : String
    var conComa : Bool
    var fecha : String
    var puntaje : String
    
    init(tiempo : String, conComa : Bool, fecha : String, puntaje : String) {
        
        
        self.tiempo = tiempo
        self.conComa = conComa
        self.fecha = fecha
        self.puntaje = puntaje
        
    }
}
