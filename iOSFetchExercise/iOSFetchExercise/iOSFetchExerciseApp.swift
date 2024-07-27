//
//  iOSFetchExerciseApp.swift
//  iOSFetchExercise
//
//  Created by Younis on 7/25/24.
//

import SwiftUI

@main
struct iOSFetchExerciseApp: App {
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
            } else {
                LaunchScreenView()
                    .onAppear {
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
