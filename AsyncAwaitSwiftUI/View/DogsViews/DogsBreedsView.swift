//
//  DogsBreedsView.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import SwiftUI

struct DogsBreedsView: View {
    @StateObject var viewModel = DogsPicturesViewModel()
    var body: some View {
        NavigationView {
            List(K.dogsBreeds, id: \.self) { dogBreed in
                NavigationLink(dogBreed.capitalized) {
                    DogsPicturesView(viewModel: viewModel, breed: dogBreed)
                }
                .navigationTitle(Text(K.perrosTitle))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct DogsBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        DogsBreedsView(viewModel: DogsPicturesViewModel())
    }
}
