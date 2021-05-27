//
//  Oracion.swift
//  SintaxisEspanol
//
//  Created by user188711 on 4/19/21.
//

import UIKit

let frases = [
	"¡Muy bien!",
	"¡Excelente!",
	"Pronto serás un experto",
	"Estás mejorando",
	"Ya se nota la práctica",
	"Vas mejorando",
	"Buena respesta",
]
//[Int.random(in: 0..<listaOraciones.count)]

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
    
    func revisar(respuesta : [String]) -> (Bool, String) {
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
        
        let resultado = validaSecuencia(secuencia, "svdice", "")
        
        return resultado
    }
	
	func getNombreParte(_ parte: String) -> String {
		switch parte {
			case "s":
				return "sujeto"
				
			case "v":
				return "verbo"
				
			case "d":
				return "objeto directo"
				
			case "i":
				return "objeto indirecto"
				
			case "c":
				return "circunstancial"
				
			case "e":
				return "extra"
				
			case ",":
				return "coma"
				
			default:
				print("Error: parte de oración no reconocida")
				return ""
		}
	}
    
	func validaSecuencia(_ secuencia: String, _ estandar: String, _ partePrevia: String) -> (Bool, String) {
        if secuencia.count == 0 {
			return (true, frases[Int.random(in: 0..<frases.count)])
			
		} else if secuencia.count == 1 && secuencia == "," {
			return (false, "Una oración no puede terminar en coma")
            
        } else {
            var secuencia = secuencia
            var estandar = estandar
            
            let parte = secuencia.removeFirst()
			
			if parte == "," && partePrevia == "," {
				return (false, "No pueden haber dos comas seguidas")
			}
            
            if parte == "," {
                return validaSecuencia(secuencia, "svdice", String(parte))
                
            } else if estandar.contains(parte) {
                while parte != estandar.removeFirst() {
                    continue
                }
                
                return validaSecuencia(secuencia, estandar, String(parte))
                
            } else {
				let nombreParte = getNombreParte(String(parte))
				let nombrePartePrevia = getNombreParte(partePrevia)
				
                return (false, "No puede ir el \(nombrePartePrevia) seguido por un \(nombreParte)")
            }
        }
    }
}
