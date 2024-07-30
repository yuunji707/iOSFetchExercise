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
        // TabView to create a tabbed interface
        TabView {
            // First tab: Desserts
            NavigationView {
                MealView()
            }
            .tabItem {
                Label("Desserts", systemImage: "birthday.cake")
            }
            
            // Second tab: Random meal
            NavigationView {
                RandomMealView()
            }
            .tabItem {
                Label("Random", systemImage: "dice")
            }
            
            // Third tab: Favorite meals
            NavigationView {
                FavoriteMealsView()
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
        .accentColor(.blue) // Set the accent color for the tab bar items
        .ignoresSafeArea(edges: .bottom) // Extend the tab bar to the bottom edge of the screen
        .onAppear {
            // Configure the tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            // Apply the appearance to both standard and scrollEdge states
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
        }
    }
}

/// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
