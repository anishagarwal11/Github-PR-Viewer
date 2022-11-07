//
//  Extension+NSObject.swift
//  practice45
//
//  Created by Anish Agarwal on 07/11/22.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
