//
//  ErrorHandler.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 06/09/2022.
//

import Foundation

// Centralizing error handling
struct ErrorHandler {
    
    static let `default` = ErrorHandler()
    
    let genericMessage = "Sorry! Something went wrong"
    
    func decodingError() {}
    
    func apiCallError() {}

}
