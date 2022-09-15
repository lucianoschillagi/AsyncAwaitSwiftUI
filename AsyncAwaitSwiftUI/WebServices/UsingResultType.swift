//
//  UsingResultType.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 07/09/2022.
//

// Topics: Result Type, Task, Error Handling Async
// https://www.hackingwithswift.com/books/ios-swiftui/understanding-swifts-result-type

import SwiftUI

enum NetworkingError: Error {
    case notSuccessRange
    case serverError
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notSuccessRange:
            return NSLocalizedString(
                "❌ the response is not in success range",
                comment: ""
            )
        case .serverError:
            return NSLocalizedString(
                "❌ the response is in server error range",
                comment: ""
            )
        }
    }
}

struct ContentView: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }.padding()
    }
    
    func fetchReadings() async {

        /// Task: a unit of async work
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, response) = try await URLSession.shared.data(from: url) // async code
            let httpUrlResponse = response as? HTTPURLResponse
            print("status_code", httpUrlResponse?.statusCode)
            print("status_code", httpUrlResponse?.status!)

            // TODO: refactor with guard statements
            if httpUrlResponse?.statusCode == 200 {
                print("todo está OK")
            }
            if httpUrlResponse!.statusCode >= 200 && httpUrlResponse!.statusCode <= 299 {
                output = NetworkingError.notSuccessRange.errorDescription ?? ""
            }
            if httpUrlResponse!.statusCode >= 500 && httpUrlResponse!.statusCode <= 599 {
                output = NetworkingError.serverError.errorDescription ?? ""
            }
            let readings = try JSONDecoder().decode([Double].self, from: data) // sync code
            return "Found \(readings.count) readings"
        }
        
        /// Result: A value that represents either a success or a failure, including an associated value in each case.
        let result = await fetchTask.result

        /// Async error handling option 3 (with Task & switch result)
        switch result {
            case .success(let str):
                output = str
                print("success request ✅")
            case .failure(let error):
                output = "Was an error: \(error.localizedDescription)"
                print("❌", error.localizedDescription)
        }
    }
}



