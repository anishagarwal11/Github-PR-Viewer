//
//  practice45Tests.swift
//  practice45Tests
//
//  Created by Anish Agarwal on 05/11/22.
//

import XCTest
@testable import practice45

class ClosedPRViewModelUT: XCTestCase {
    
    var viewModel: ViewModelDataSource?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_API_call_for_success_case() throws {
        viewModel = ClosePRListViewModel(MockNetworkClient(.sucess))
        viewModel?.data = []
        
        let expectation = XCTestExpectation(description: "test_for_sucess_response")

        viewModel?.updateUI = {
            expectation.fulfill()
        }
        viewModel?.getDataFromServer()

        self.wait(for: [expectation], timeout: 30)
    }
    
    func test_API_call_for_failure_case() throws {
        viewModel = ClosePRListViewModel(MockNetworkClient(.failure))
        viewModel?.data = []
        
        let expectation = XCTestExpectation(description: "test_for_error_response")
        viewModel?.showAlert = { errorData in
            XCTAssertNotNil(errorData)
            expectation.fulfill()
        }
        viewModel?.getDataFromServer()
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func test_API_call_for_empty_case() throws {
        viewModel = ClosePRListViewModel(MockNetworkClient(.emptyResponse))
        viewModel?.data = []
        
        let expectation = XCTestExpectation(description: "test_for_empty_response")
        viewModel?.showAlert = { errorData in
            XCTAssertNotNil(errorData)
            expectation.fulfill()
        }
        viewModel?.getDataFromServer()
        
        self.wait(for: [expectation], timeout: 30)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
