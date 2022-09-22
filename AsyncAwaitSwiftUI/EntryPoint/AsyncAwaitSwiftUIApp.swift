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
<<<<<<< HEAD
                        }
=======
                    }
>>>>>>> 7c5749b3b16235d6683bc568e74a24002199b22f
                    DogsBreedsView()
                        .tabItem {
                            Image(systemName: "pawprint.fill")
                                .foregroundColor(.primary)
<<<<<<< HEAD
                        }
                }
            }
//            ContentView()
=======
                    }
                }
            }
>>>>>>> 7c5749b3b16235d6683bc568e74a24002199b22f
        }
    }
}




