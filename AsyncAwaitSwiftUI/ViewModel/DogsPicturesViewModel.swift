//
//  DogsPicturesViewModel.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import Foundation

// MARK: - ViewModel
class DogsPicturesViewModel: ObservableObject {
    @Published var searchedDogsBreed: [String] = [""]// combine publisher
    @Published var isLoading = false
}
