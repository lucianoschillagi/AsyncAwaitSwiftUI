//
//  AlbumDetailView.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 10/08/2022.
//

import SwiftUI

// MARK: - View

struct AlbumDetailView: View {
    @StateObject private var viewModel = AlbumDetailViewModel()
    var artist: String
    var body: some View {
        ZStack {
            List(viewModel.searchedAlbums) { album in
                Text(album.collectionName)
          }
            .onAppear {
                Task {
                    await viewModel.getAlbums(artist: artist) // async code ⌛️
                }
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}


// MARK: - Previews
struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(artist: "AC/DC")
    }
}
