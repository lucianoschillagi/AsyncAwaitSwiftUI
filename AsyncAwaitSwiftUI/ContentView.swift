//
//  ContentView.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 28/07/2022.
//

import SwiftUI

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
    func searchBooks(searchTerm: String) async -> String {
        let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/Swift/definitions?word=Swift")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            debugPrint("Los datos recibidos son", data)
            // Parsing goes here
        
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
