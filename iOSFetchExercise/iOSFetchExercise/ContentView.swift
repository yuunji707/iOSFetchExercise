//
//  ContentView.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// The main view of the application
struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                MealView()
            }
            .tabItem {
                Label("Desserts", systemImage: "birthday.cake")
            }
            
            NavigationView {
                RandomMealView()
            }
            .tabItem {
                Label("Random", systemImage: "dice")
            }
            
            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
        .accentColor(.blue)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
        }
    }
}

/// A placeholder view for the Favorites tab
struct FavoritesView: View {
    var body: some View {
        Text("Favorites View")
            .navigationTitle("Favorites")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
