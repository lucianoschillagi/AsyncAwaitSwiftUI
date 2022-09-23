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
//    @MainActor
//    func getAlbums(artist: String) async  {
//        // TODO: Use Task and Result
//        let url = ItunesAPI.getAlbums(artist: artist).url!
//        isLoading = true
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url) // async code
//            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data) // sync code
//            isLoading = false
//            self.searchedAlbums = decodedAlbum.results
//        }
//        
//        // MARK: - handling do block error here
//        catch {
//            print(NetworkRequestError.catchError)
//        }
//        // Decoding error scenario ❌
//         catch let DecodingError.dataCorrupted(context) {
//            print("☠️ Data corrupted:", context)
//        } catch let DecodingError.keyNotFound(key, context) {
//            print("🔑 Key '\(key)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.valueNotFound(value, context) {
//            print("Value '\(value)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.typeMismatch(type, context)  {
//            print("😳 Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch {
//            print("error: ", error)
//        }
//    }
    
    @MainActor
    func getAlbums(artist: String) async  {
        isLoading = true
        let fetchTask = Task { () -> [ArtistAlbum] in
            let url = ItunesAPI.getAlbums(artist: artist).url!
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpUrlResponse = response as? HTTPURLResponse
            if let statusCodeTemp = httpUrlResponse?.statusCode {
                self.statusCode = statusCodeTemp
            }
            isLoading = false
            /// Handling HTTP URL Server Response
            // ERROR scenario ❌
            if statusCode >= 400 && statusCode <= 499 {
                alertMessage = NetworkingError.clientError.errorDescription ?? ""
                hasAnError = true
            }
            if statusCode >= 500 && statusCode <= 599 {
                alertMessage = NetworkingError.serverError.errorDescription ?? ""
                hasAnError = true
            }
            /// OK scenario ✅
            if httpUrlResponse?.statusCode == 200 {
                print("todo está OK")
            }
            let decodedAlbum = try JSONDecoder().decode(AlbumResponse.self, from: data)
            return decodedAlbum.results
        }
        let result = await fetchTask.result

        switch result {
        case .success(let artist):
            self.searchedAlbums = artist
        case .failure(let error):
            print(error.localizedDescription)
            self.alertMessage = error.localizedDescription
            self.hasAnError = true
        }
        
//        let url = DogsAPI.getDogsPicture(breed: breed).url!
//        print(url)
//        isLoading = true
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            let decodedDogsBreed = try JSONDecoder().decode(DogsBreedResponse.self, from: data)
//            isLoading = false
//            self.searchedDogsBreed = decodedDogsBreed.message
//
//            // MARK: - handling server responses here
//            let serverResponse = response as? HTTPURLResponse
//            print("👉", data)
//            print("👉", serverResponse?.statusCode)
//
//            // TODO: Switch with ´enum HTTPStatusCode: Int, Error {}´
//
//
//        }
//
//        // MARK: - handling do block error here
//        // ERROR scenario ❌
//        catch {
//
//
//        }
      
    }
}


