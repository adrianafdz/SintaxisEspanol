//
//  Oracion.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/19/21.
//

import UIKit

class Oracion: NSObject, Codable {
    // var partes: [String: String] = [:]
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
        
        // self.partes[sujeto] = "s"
        // self.partes[verbo] = "v"
        // self.partes[objDirecto] = "d"
        // self.partes[objIndirecto] = "i"
        // self.partes[circunstancial] = "c"
        // self.partes[extra] = "e"
    }
    
    func getRespuestaSinComas() -> [String] {
        var arr = [String]()
        
        if sujeto! != "" {
            arr.append(sujeto!)
        }
        
        arr.append(verbo)
        
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

        return arr
    }
    
    func getPartes() -> [String] {
        var arr = self.getRespuestaSinComas()
        
        arr.shuffle()
        return arr
    }
    
    func revisarSinComas(respuesta : [String]) -> Bool {
        return respuesta == self.getRespuestaSinComas()
    }
}
