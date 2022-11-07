//
//  NetworkManager.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import Foundation

enum CustomError: Error {
    case decodingError
    case apiFailed
    case custom(Error)
    case statusCodeError(Int)
}

protocol NetworkProtocol {
    func getJsonDecodableFromServer<T: Decodable>(_ url: URL, completionHandler: @escaping(_ result: Result<T, CustomError>) -> Void)
    
    func getDataFromServer(_ url: URL, completionHandler: @escaping(_ result: Result<Data, CustomError>) -> Void)
}

class NetworkManger: NetworkProtocol {
    
    static let shared = NetworkManger()
    private init() { }
    
    //Assumption: Only Supporting HTTP GET
    func getJsonDecodableFromServer<T: Decodable>(_ url: URL, completionHandler: @escaping(_ result: Result<T, CustomError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if data != nil , error == nil {
                if let dataFromAPI = data, let decodedData = try? JSONDecoder().decode(T.self, from: dataFromAPI){
                    completionHandler(.success(decodedData))
                }
                else {
                    completionHandler(.failure(.decodingError))
                }
            }
            else if let errorMessage = error {
                completionHandler(.failure(.custom(errorMessage)))
            }
            else if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                completionHandler(.failure(.statusCodeError(response.statusCode)))
            }
        }.resume()
    }
    
    func getDataFromServer(_ url: URL, completionHandler: @escaping(_ result: Result<Data, CustomError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if data != nil , error == nil {
                if let data = data {
                    completionHandler(.success(data))
                }
                else {
                    completionHandler(.failure(.decodingError))
                }
            }
            else if error != nil {
                completionHandler(.failure(.apiFailed))
            }
            //TODO: handle for response status code
            else {
                completionHandler(.failure(.apiFailed))
            }
        }.resume()
    }
    
}
