//
//  MainView.swift
//  Nutrify
//
//  Main app interface with tab navigation
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DietView()
                .tabItem {
                    Label("Diet", systemImage: "fork.knife")
                }
                .tag(0)
            
            ExerciseView()
                .tabItem {
                    Label("Exercise", systemImage: "figure.run")
                }
                .tag(1)
            
            RecoveryView()
                .tabItem {
                    Label("Recovery", systemImage: "bed.double")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(3)
        }
    }
}

// DietView is now in its own file

struct ExerciseView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                Text("Exercise Tracking")
                    .font(.largeTitle)
            }
            .navigationTitle("Exercise")
        }
    }
}

struct RecoveryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                Text("Recovery Tracking")
                    .font(.largeTitle)
            }
            .navigationTitle("Recovery")
        }
    }
}

#Preview {
    MainView()
}
