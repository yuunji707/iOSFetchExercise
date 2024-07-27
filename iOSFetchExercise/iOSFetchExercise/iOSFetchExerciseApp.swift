//
//  iOSFetchExerciseApp.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

/// The main entry point of the application
@main
struct iOSFetchExerciseApp: App {
    // State to control whether to show the launch screen or the main content
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                // Show the main content view after the launch screen
                ContentView()
            } else {
                // Show the launch screen
                LaunchScreenView()
                    .onAppear {
                        // Simulate a delay before transitioning to the main content
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
    }
}

/// A view representing the launch screen of the application
struct LaunchScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            Image("LaunchScreenImage")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.black) // Add a background color if needed
                .edgesIgnoringSafeArea(.all)
        }
    }
}
