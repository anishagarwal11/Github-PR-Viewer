//
//  File.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import Foundation


protocol ViewModelDataSource {
    
    var data: [ClosedPRElement] { get set }
    var updateUI: (() -> Void)? { get set }
    var allDataFetchedShowMessage: (() -> Void)? { get set }
    var showAlert: ((CustomError) -> Void)? { get set }
    func getNumberOfRows() -> Int
    func getRowData(rowIndex: Int) -> ClosedPRElement
    func getDataFromServer()
    func getMoreDataFromServer()
}

class ClosePRListViewModel: ViewModelDataSource {
    
    var allDataFetchedShowMessage: (() -> Void)?
    var showAlert: ((CustomError) -> Void)?
    var updateUI: (() -> Void)?
    var data: [ClosedPRElement] = []
    var networkManager: NetworkProtocol?
    var isGetMoreDataRequestActive = false
    var pageNumber = 1
    var baseURL = Constants.URL.baseURL.closedPrUrl
    var apiCallURL: URL?
    
    init(_ network: NetworkProtocol) {
        self.networkManager = network
    }
    
    func getNumberOfRows() -> Int {
        return data.count 
    }
    
    func getRowData(rowIndex: Int) -> ClosedPRElement {
        return data[rowIndex] 
    }
    
    func getDataFromServer() {
        
        makeURL()
        guard let url = apiCallURL else{return}
        networkManager?.getJsonDecodableFromServer(url, completionHandler: { [weak self] (result: Result<[ClosedPRElement], CustomError>) in
            self?.isGetMoreDataRequestActive = false
            switch result {
            case .success(let success):
                if(success.count == 0) {
                    self?.allDataFetchedShowMessage?()
                }
                else {
                    self?.data += success
                    self?.updateUI?()
                }
            case .failure(let failure):
                self?.showAlert?(failure)
            }
        })
        
    }
    
    func getMoreDataFromServer() {
        if !isGetMoreDataRequestActive {
            isGetMoreDataRequestActive = true
            increasePageNumber()
            getDataFromServer()
        }
    }
    
    private func makeURL() {
        let urlString = baseURL + "&page=\(pageNumber)&per_page=7"
        guard let url = URL(string: urlString) else { return }
        apiCallURL = url
    }
    
    private func increasePageNumber() {
        pageNumber += 1
    }
    
}

