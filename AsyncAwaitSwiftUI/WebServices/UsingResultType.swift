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
    case one
    case two
    case three
}

struct ContentView: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }.padding()
    }

    /// Async error handling option 1 (with do try catch)
//    func fetchReadings() async {
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url) // async
//            let readings = try JSONDecoder().decode([Double].self, from: data) // sync
//            output = "Found \(readings.count) readings"
//        } catch {
//            print("❌ Download error \(error.localizedDescription)")
//        }
//    }
    
    func fetchReadings() async {

        /// Task: a unit of async work
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }

        /// Result: A value that represents either a success or a failure, including an associated value in each case.
        let result = await fetchTask.result


        /// Async error handling option 2 (with Task & do try catch)
//        do {
//            output = try result.get()
//        } catch {
//            output = "❌ Error: \(error.localizedDescription)"
//        }

        /// Async error handling option 3 (with Task & switch result)
        switch result {
            case .success(let str):
                output = str
            
            
            
            case .failure(let error):
            
                output = "Error: \(error.localizedDescription)"
                print("❌", NetworkingError.one)
            
            
            
        }
        
        
    }
    
    
}



