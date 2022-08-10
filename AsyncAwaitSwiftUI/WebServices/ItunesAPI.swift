//
//  ItunesAPI.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 10/08/2022.
//

import Foundation

// MARK: - Networking

// Ref: https://medium.com/swlh/building-urls-in-swift-51f21240c537
enum ItunesAPI {
    
//    // Builds a URL to 'get words definitions' method
//    case getWordDefinitions(word: String)
//
//    // Builds a URL to '----' method
////    case anotherCase
//
//    // Returns the called URL
//    // https://wordsapiv1.p.rapidapi.com/words/Swift/definitions?word=swift
//    // https:// 👉 Scheme
//    // wordsapiv1.p.rapidapi.com/ 👉 Host
//    // words/Swift/definitions 👉 Path
//    // ?word=swift 👉 Query
//    var url: URL? {
//        var component = URLComponents()
//        component.scheme = K.SCHEME // static
//        component.host = K.WORD_API_HOST // static
//        component.path = wordPath() ?? K.WORD_PATH_DEFAULT // dynamic
//        component.queryItems = wordQuery() // dynamic
//        return component.url
//    }
//
//    // path builder
//    private func wordPath() -> String? {
//        // https://wordsapiv1.p.rapidapi.com/words/Swift/definitions
//        switch self {
//        case .getWordDefinitions(let word):
//            return "words/\(word.description)/definitions"
//        }
//    }
//
//    // query builder
//    private func wordQuery() -> [URLQueryItem]? {
//        switch self {
//        case .getWordDefinitions(let word):
//            return [URLQueryItem(name: "word", value: word.description)]
//        }
//    }
}

extension AlbumDetailViewModel {
    
    // Networking
    @MainActor
    func getAlbums(artist: String) async  {
        let url = URL(string: "https://itunes.apple.com/search?term=devo&entity=album")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data)
            self.searchedAlbums = decodedAlbum.results
        }
        catch {
            
        }
       
      }
}


