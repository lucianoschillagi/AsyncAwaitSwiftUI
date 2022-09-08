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
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https" // static
        component.host = "itunes.apple.com" // static
        component.path = "/search" // dynamic
        component.queryItems = queryBuilder() // dynamic
        return component.url
    }

    // query builder
    private func queryBuilder() -> [URLQueryItem]? {
        switch self {
        case .getAlbums(let album):
            return [URLQueryItem(name: "term", value: album.description),
                    URLQueryItem(name: "entity", value: "album")]
       //            URLQueryItem(name: "entity", value: "albffum")]
        }
    }
    
    // path builder
//    private func pathBuilder() -> String? {
//        // https://wordsapiv1.p.rapidapi.com/words/Swift/definitions
//        switch self {
//        case .getAlbums(let word):
//            return "words/\(word.description)/definitions"
//        }
//    }
    
}

extension AlbumDetailViewModel {
    
    // Networking
    @MainActor
    func getAlbums(artist: String) async  {
        let url = ItunesAPI.getAlbums(artist: artist).url!
        isLoading = true
        do {
            let (data, response) = try await URLSession.shared.data(from: url) // async code
            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data) // sync code
            isLoading = false
            self.searchedAlbums = decodedAlbum.results
            
            // MARK: - handling server responses here
            
            
            
            let serverResponse = response as? HTTPURLResponse
            print("👉", data)
            print("👉", Int(serverResponse?.statusCode ?? 200))
            
            // GUARD-b: if response is not in success range
            guard let statusCode = serverResponse?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print(NetworkRequestError.notSuccessRange)
                return
            }

            // GUARD-c: if response is in server error range (500-599)
            guard let serverError = serverResponse?.statusCode, serverError >= 500 && serverError <= 599 else {
                print(NetworkRequestError.serverError)
                print(serverResponse?.statusCode)
                return
            }
     
            
        }
        
        // MARK: - handling do block error here
        catch {
            print(NetworkRequestError.catchError)
        }
        // Decoding error scenario ❌
         catch let DecodingError.dataCorrupted(context) {
            print("☠️ Data corrupted:", context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("🔑 Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("😳 Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
//        catch {
//            ErrorHandler.default.decodingError()
//            ErrorHandler.default.apiCallError()
//        }
        
        
    }
}


