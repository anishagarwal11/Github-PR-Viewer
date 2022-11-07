//
//  ImageDownloader.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import Foundation

class ImageDownloader {
        
    func getImage(url:URL, onCompletion: @escaping (_ result: Result<Data, CustomError>) -> Void) {
        //Assumption: Not Supporting Image Caching
        NetworkManger.shared.getDataFromServer(url){ (result: Result<Data, CustomError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    onCompletion(.success(data))
                case .failure(let error):
                    onCompletion(.failure(error))
                }
            }
        }
    }
}
