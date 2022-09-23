//
//  AsyncAwaitSwiftUIApp.swift
//  AsyncAwaitSwiftUI
//
//  Created by Luko on 28/07/2022.
//

import SwiftUI

@main
struct AsyncAwaitSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    ArtistsView()
                        .tabItem {
                            Image(systemName: "music.note")
                        }
                    DogsBreedsView()
                        .tabItem {
                            Image(systemName: "pawprint.fill")
                                .foregroundColor(.primary)
                        }
                }
            }
        }
    }
}




