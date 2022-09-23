//
//  AlbumDetailViewModel.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 10/08/2022.
//

import Foundation

// MARK: - ViewModel
class AlbumDetailViewModel: ObservableObject {
    @Published var searchedAlbums = [ArtistAlbum]()// combine publisher
    @Published var isLoading = false
    @Published var statusCode = 0
    // error scenario
    @Published var hasAnError = false
    @Published var alertMessage = ""
}

