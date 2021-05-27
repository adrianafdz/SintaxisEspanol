//
//  FileManager+Ext.swift
//  SintaxisEspanol
//
//  Created by Juventino Gutierrez on 26/05/21.
//

import Foundation

extension FileManager{
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func pathToDocumentsDirectory(with filename: String) -> URL{
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
