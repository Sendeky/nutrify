//
//  nutrifyApp.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

import SwiftUI

@main
struct NutrifyApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = false
    
    var body: some Scene {
        WindowGroup {
            if !hasCompletedOnboarding {
                GetStartedView()
            } else if !hasCompletedSetup {
                SetupView()
            } else {
                MainView()
            }
        }
    }
}
