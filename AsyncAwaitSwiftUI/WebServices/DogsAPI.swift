//
//  DogsAPI.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import Foundation

// MARK: - Networking

// Ref: https://medium.com/swlh/building-urls-in-swift-51f21240c537
enum DogsAPI {
    
    // Builds a URL to 'get dog's pictures by breed' method
    case getDogsPicture(breed: String)

    // Builds a URL to '----' method
//    case anotherCase

    // Returns the called URL
    // https://dog.ceo/api/breed/(breed)/images
    // https:// 👉 Scheme
    // dog.ceo/api/ 👉 Host
    // breed/ 👉 Path
    // (breed)/images 👉 Query
    
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https" // static
        component.host = "dog.ceo" // static
        component.path = dogsBreedPath() ?? "" // dynamic
//        component.queryItems = dogsBreedQuery() // dynamic
        return component.url
    }

//     path builder
    private func dogsBreedPath() -> String? {
        // https://wordsapiv1.p.rapidapi.com/words/Swift/definitions
        switch self {
        case .getDogsPicture(let breed):
            return "/api/breed/\(breed.description)/images/random/20"
        }
    }

//    // query builder
//    private func dogsBreedQuery() -> [URLQueryItem]? {
//        switch self {
//        case .getDogsPicture(let breed):
//            return [URLQueryItem(name: "breed", value: breed.description)]
//
//        }
//    }
}

extension DogsPicturesViewModel {

    // Networking
    @MainActor
    func getDogsPicture(breed: String) async  {
        
        // TODO: Use Task and Result
        let fetchTask = Task { () -> [String] in
            let url = DogsAPI.getDogsPicture(breed: breed).url!
            let (data, response) = try await URLSession.shared.data(from: url)
            let decodedDogsBreed = try JSONDecoder().decode(DogsBreedResponse.self, from: data)

//            let httpUrlResponse = response as? HTTPURLResponse
//            
//            if httpUrlResponse?.statusCode == 200 {
//                print("todo está OK")
//            }
//            if httpUrlResponse!.statusCode >= 200 && httpUrlResponse!.statusCode <= 299 {
//                alertMessage = NetworkingError.notSuccessRange.errorDescription ?? ""
//            }
//            if httpUrlResponse!.statusCode >= 500 && httpUrlResponse!.statusCode <= 599 {
//                alertMessage = NetworkingError.serverError.errorDescription ?? ""
//            }
//            if (response as? HTTPURLResponse)?.statusCode == 200 {
//                let decodedDogsBreed = try JSONDecoder().decode(DogsBreedResponse.self, from: data)
//                return decodedDogsBreed.message
//            }
            return decodedDogsBreed.message
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let breeds):
            self.searchedDogsBreed = breeds
        case .failure(let error):
            print(error.localizedDescription)
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
