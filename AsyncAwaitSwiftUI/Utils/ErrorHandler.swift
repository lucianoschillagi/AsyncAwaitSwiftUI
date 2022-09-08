//
//  ErrorHandler.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 06/09/2022.
//

import Foundation

enum NetworkRequestError: Error {
    case notSuccessRange
    case serverError
    case catchError
}

extension NetworkRequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notSuccessRange:
            return NSLocalizedString(
                "❌ Not Success Range",
                comment: ""
            )
        case .serverError:
            return NSLocalizedString(
                "❌ Server Error",
                comment: ""
            )
        case .catchError:
            let format = NSLocalizedString(
                "❌ CATCH ERROR",
                comment: ""
            )
        
            
            return String(format: format)

        }
    }
}

// TODO: Centralizing error handling
struct ErrorHandler {
    
    static let `default` = ErrorHandler()
    
    let genericMessage = "Sorry! Something went wrong"
    
    func decodingError() {}
    
    func apiCallError() {}

}
