//
//  PersistenciaHelp.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 26/05/21.
//

import Foundation

enum DataPersistenceError: Error{
    case savingError(Error)
    case noFile(String)
    case noData
    case loadingError(Error)
    case deleteError(Error)
}

class PersistenceHelper{
    
    private static var scores = [Score]()
    private static let filename = "HighScore.plist"
    //create
    
    
    private static func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        do{
            let data = try PropertyListEncoder().encode(scores)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    static func create(score: Score) throws{
        scores.append(score)
        do{
        try save()
        } catch{
            throw DataPersistenceError.savingError(error)
        }
    }
    //read
    static func loadScores() throws -> [Score]{
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        if FileManager.default.fileExists(atPath: url.path){
            
            if let data = FileManager.default.contents(atPath: url.path){
                do {
                    scores = try PropertyListDecoder().decode([Score].self, from: data)
                } catch {
                    throw DataPersistenceError.loadingError(error)
                    
                }
            }else{
                throw DataPersistenceError.noData
                
            }
            
        }else{
            throw DataPersistenceError.noFile(filename)
        }
        return scores
    }
    
    
    //delete
    static func delete(score index: Int) throws{
        scores.remove(at: index)
        do{
            try save()
        } catch{
            throw DataPersistenceError.deleteError(error)
        }
    }
    
}
