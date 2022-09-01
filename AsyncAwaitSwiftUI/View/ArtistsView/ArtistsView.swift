//
//  ArtistsView.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import SwiftUI

struct ArtistsView: View {
    @StateObject private var viewModel = AlbumDetailViewModel()
    var body: some View {
        NavigationView {
            List(K.artists, id: \.self) { artist in
                NavigationLink(artist) {
                    AlbumDetailView(artist: artist)
                }
            }
            .navigationTitle(Text(K.artistasTitle))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
