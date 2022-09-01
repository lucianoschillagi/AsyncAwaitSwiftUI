//
//  DogsBreedModel.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import Foundation

// MARK: - Model
/// The result of the dog´s breed search
struct DogsBreedResponse: Codable {
    let message: [String] // plural
    let status: String
}
