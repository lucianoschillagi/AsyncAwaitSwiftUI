//
//  ContentView.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 28/07/2022.
//

import SwiftUI

// https://peterfriese.dev/posts/swiftui-concurrency-essentials-part1/

/* TODO:
 - Handling request errors
 - Enum for case errors
 - Move code pieces to file layers
 - Populate Word model object
 - Prototype UI: Main & Detail screens
 - Navigation btw to screens
 - Create: func buildURLRequest(for searchTerm: String) -> URLRequest
 - Create: search(for searchTerm: String) async -> Word { ... }
 - Create: func executeQuery(for searchTerm: String) async
 - Implement @MainActor attribute
 - ...
*/

// Model
/// Representa una palabra y sus definiciones
struct Word {
  let word: String // singular
  let definitions: [String] // plural
}

/// Representa la definición de una palabra
struct Definition {
  let definition: String
}

// ViewModel
class WordDetailsViewModel: ObservableObject {
    
    // Networking
    func searchBooks(searchTerm: String) async -> String {
        let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/Swift/definitions?word=Swift")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            debugPrint("Los datos recibidos son", data)
            // TODO: Parsing goes here
        }
        catch {
          return ""
        }
        return ""
      }
}

// View
struct ContentView: View {
    @StateObject private var viewModel = WordDetailsViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.onAppear {
            Task {
              await viewModel.searchBooks(searchTerm: "Swift") // async code ⌛️
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
