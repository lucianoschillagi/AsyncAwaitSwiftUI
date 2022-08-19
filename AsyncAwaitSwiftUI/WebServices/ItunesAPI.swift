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
    // itunes.apple.com/ 👉 Host
    // search 👉 Path
    // ?term=devo&entity=album 👉 Query
    
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
            return [URLQueryItem(name: "term", value: album.description),
                    URLQueryItem(name: "entity", value: "album")]
       //            URLQueryItem(name: "entity", value: "albffum")]
            
        }
    }
}

extension AlbumDetailViewModel {
    
    // Networking
    @MainActor
    func getAlbums(artist: String) async  {
        let url = ItunesAPI.getAlbums(artist: artist).url!
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data)
            self.searchedAlbums = decodedAlbum.results
            
            // MARK: - handling server responses here
            let serverResponse = response as? HTTPURLResponse
            print("👉", data)
            print("👉", serverResponse?.statusCode)
            
            // NOTE: la codeline del 'try' Sí se pudo ejecutar
            print("👉 La request SÍ se pudo ejecutar")
            // OK scenario ✅
            // 200-299
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 300 && statusCode <= 599 else {
                print("server response is btw 200-299, ✅")
                return
            }
            
            // ERROR scenario ❌
            // 400-499
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("server response is btw 400-499, ❌, todo: handle the error")
                return
            }
            
        }
        
        // MARK: - handling do block error here
        // ERROR scenario ❌
        catch {
            // NOTE: la codeline del 'try' NO se pudo ejecutar
            print(" 👉 La request NO se pudo ejecutar")
            
        }
      }
}


