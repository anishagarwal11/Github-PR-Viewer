//
//  Constants.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import Foundation

struct Constants {
    struct AlertConstants {
        struct Title {
            static let apiFailureTitle = "API Failure"
            static let decodingErrorTitle = "Decoding Error"
        }
        
        struct Message {
            static let apiFailureMessage = "Please check you internet connection"
            static let decodingErrorMessage = "Please retry"
        }
        
        struct AlertAction {
            static let okAction = "Ok"
        }
    }
    
    struct TableViewHeaderFooterLabels {
        struct FooterLabelMessage {
            static let allDataFetchedFooter = "All data Fetched!"
        }
        
        struct HeaderLabelMessage {
            static let listOfPRHeader = "List of closed PR's from openstack"
        }
    }
    
    struct URL {
        struct baseURL {
            static let closedPrUrl = "https://api.github.com/repos/openstack/swift/pulls?state=closed"
        }
    }
    
    struct ImagesAssets {
        static let defualtImage = "defualtImage"
    }
    
}
