//
//  Oracion.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/19/21.
//

import UIKit

class Oracion: NSObject, Codable {
    var sujeto : String!
    var verbo : String
    var objDirecto : String!
    var objIndirecto : String!
    var circunstancial : String!
    var extra : String!
    
    init(sujeto : String!, verbo : String, objDirecto : String!, objIndirecto: String!, circunstancial : String!, extra : String!) {
        self.sujeto = sujeto
        self.verbo = verbo
        self.objDirecto = objDirecto
        self.objIndirecto = objIndirecto
        self.circunstancial = circunstancial
        self.extra = extra
    }
    
    func getPartes() -> [String] {
        var arr = [verbo]
        
        if sujeto! != "" {
            arr.append(sujeto!)
        }
        
        if objDirecto! != "" {
            arr.append(objDirecto!)
        }
        
        if objIndirecto! != "" {
            arr.append(objIndirecto!)
        }
        
        if circunstancial! != "" {
            arr.append(circunstancial!)
        }
        
        if extra! != "" {
            arr.append(extra!)
        }
        
        arr.shuffle()
        return arr
    }
}
