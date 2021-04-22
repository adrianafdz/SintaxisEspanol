//
//  Score.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 21/04/21.
//

import UIKit

class Score: NSObject {
    var fecha : String
    var tiempo : String
    var puntaje : String
    var conComa : Bool
    
    init(fecha : String, tiempo : String, puntaje : String, conComa : Bool) {
        
        self.fecha = fecha
        self.tiempo = tiempo
        self.puntaje = puntaje
        self.conComa = conComa
    }
}
