//
//  MockNetworkClient.swift
//  practice45Tests
//
//  Created by Anish Agarwal on 07/11/22.
//

import Foundation
@testable import practice45

enum ResponseType {
    case emptyResponse
    case failure
    case sucess
}

class MockNetworkClient: NetworkProtocol {
    var data: Data?
    init(_ responseType: ResponseType) {
        setResponse(type: responseType)
    }
    
    func setResponse(type: ResponseType) {
        switch type {
        case .sucess:
            data = JsonStubs.shared.getJSON(from: "closedPRSuccessStub")
        case .failure:
            data = JsonStubs.shared.getJSON(from: "closedPRFailureStub")
        case .emptyResponse:
            data = JsonStubs.shared.getJSON(from: "emptyResponseStub")
        }
    }
    
    func getJsonDecodableFromServer<T: Decodable>(_ url: URL, completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        if let dataFromAPI = data, let decodedData = try? JSONDecoder().decode(T.self, from: dataFromAPI){
            completionHandler(.success(decodedData))
        }else {
            completionHandler(.failure(.decodingError))
        }
    }
    
    func getDataFromServer(_ url: URL, completionHandler: @escaping (Result<Data, CustomError>) -> Void) {
        //TODO:
    }
}

