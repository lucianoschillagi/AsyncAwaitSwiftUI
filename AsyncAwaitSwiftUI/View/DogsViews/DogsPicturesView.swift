//
//  DogsPicturesView.swift
//  AsyncAwaitSwiftUI
//
//  Created by German Rosso on 25/08/2022.
//

import SwiftUI

struct DogsPicturesView: View {
    @StateObject var viewModel: DogsPicturesViewModel
    var breed: String
    let columns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        gridView
            .onAppear {
                Task {
                    await viewModel.getDogsPicture(breed: breed)
                }
            }
    }
    
    private var gridView: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(columns: columns) {
                    imagesButtonView
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var imagesButtonView: some View {
        ForEach(viewModel.searchedDogsBreed.prefix(10), id: \.self) { dogPicture in
            Button {
                //
            } label: {
                AsyncImage(
                    url: URL(string: dogPicture),
                    content: { image in
                        image.resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 100)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
            .disabled(true)
        }
        .padding(.bottom)
    }
}

struct DogsPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        DogsPicturesView(viewModel: DogsPicturesViewModel(), breed: "labrador")
    }
}
