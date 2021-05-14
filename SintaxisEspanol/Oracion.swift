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
    
    func getPartesEnDesorden() -> [String] {
        var arr = self.getPartes()
        
        arr.shuffle()
        return arr
    }
    
    func revisar(respuesta : [String]) -> Bool {
        var secuencia = ""
        
        for parte in respuesta {
            switch parte {
                case self.sujeto:
                    secuencia += "s"
                    
                case self.verbo:
                    secuencia += "v"
                    
                case self.objDirecto:
                    secuencia += "d"
                    
                case self.objIndirecto:
                    secuencia += "i"
                    
                case self.circunstancial:
                    secuencia += "c"
                    
                case self.extra:
                    secuencia += "e"
                    
                case ",":
                    secuencia += ","
                    
                default:
                    print("Error: parte de oración no reconocida")
            }
        }
        
        let resultado = validaSecuencia(secuencia, "svdice")
        
        return resultado
    }
    
    func validaSecuencia(_ secuencia: String, _ estandar: String) -> Bool {
        if secuencia.count == 0 {
            return true
            
        } else {
            var secuencia = secuencia
            var estandar = estandar
            
            let parte = secuencia.removeFirst()
            
            if parte == "," {
                return validaSecuencia(secuencia, "svdice")
                
            } else if estandar.contains(parte) {
                while parte != estandar.removeFirst() {
                    continue
                }
                
                return validaSecuencia(secuencia, estandar)
                
            } else {
                return false
            }
        }
    }
}
