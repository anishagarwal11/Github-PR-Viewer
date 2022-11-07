//
//  File.swift
//  practice45Tests
//
//  Created by Anish Agarwal on 06/11/22.
//
import Foundation

class JsonStubs {
    static var shared = JsonStubs()
    private init() {}
    
    func getJSON(from file: String, type: String = "json") -> Data? {
        
        guard
        let path = Bundle.main.path(forResource: file, ofType: type),
        let string = try? String(contentsOfFile: path, encoding: String.Encoding.utf8),
        let data = string.data(using: .utf8)
        else {
            return Data()
        }
        return data
    }
    
    func getError(from file: String, type: String = "json") -> Error? {
        
        guard
            let path = Bundle.main.path(forResource: file, ofType: type),
            let string = try? String(contentsOfFile: path, encoding: String.Encoding.utf8),
            let data = string.data(using: .utf8)
        else {
            return nil
        }
        return data as? Error
    }
    
}

