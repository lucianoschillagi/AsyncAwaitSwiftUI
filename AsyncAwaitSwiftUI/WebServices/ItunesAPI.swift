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
    
    // Builds a URL to 'get artist's albums' method
    case getAlbums(artist: String)

    // Builds a URL to '----' method
//    case anotherCase

    // Returns the called URL
    // https://itunes.apple.com/search?term=devo&entity=album
    // https:// 👉 Scheme
    // wordsapiv1.p.rapidapi.com/ 👉 Host
    // words/Swift/definitions 👉 Path
    // ?word=swift 👉 Query
    
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https" // static
        component.host = "itunes.apple.com" // static
        component.path = "/search" // dynamic
        component.queryItems = wordQuery() // dynamic
        return component.url
    }

    // path builder
//    private func wordPath() -> String? {
//        // https://wordsapiv1.p.rapidapi.com/words/Swift/definitions
//        switch self {
//        case .getAlbums(let word):
//            return "words/\(word.description)/definitions"
//        }
//    }

    // query builder
    private func wordQuery() -> [URLQueryItem]? {
        switch self {
        case .getAlbums(let album):
            return [URLQueryItem(name: "term", value: album.description), URLQueryItem(name: "entity", value: "album")]
        }
    }
}

extension AlbumDetailViewModel {
    
    // Networking
    @MainActor
    func getAlbums(artist: String) async  {
        let url = ItunesAPI.getAlbums(artist: artist).url!
        
        // OK scenario ✅
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data)
            self.searchedAlbums = decodedAlbum.results
        }
        // ERROR scenario ❌
        catch {
            
        }
      }
}


