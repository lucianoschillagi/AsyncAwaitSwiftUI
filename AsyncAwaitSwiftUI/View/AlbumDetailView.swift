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
    var body: some View {
        List(viewModel.searchedAlbums) { album in
            Text(album.collectionName)
      }
        .onAppear {
            Task {
                await viewModel.getAlbums(artist: "devo") // async code ⌛️
            }
        }
    }
}


// MARK: - Previews
struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView()
    }
}
