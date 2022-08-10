//
//  AlbumModel.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 10/08/2022.
//

import Foundation

// MARK: - Model
/// The result of the artist album search
struct AlbumResponse: Codable {
    let resultCount: Int // single
    let results: [ArtistAlbum] // plural
}

/// The artist albums with its names
class ArtistAlbum: Codable, Identifiable {
    let collectionId: Int
    let collectionName: String
    
}

