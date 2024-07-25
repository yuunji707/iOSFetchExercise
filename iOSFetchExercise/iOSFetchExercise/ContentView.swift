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
        NavigationView {
            MealView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
