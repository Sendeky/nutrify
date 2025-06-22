//
//  GetStartedView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct GetStartedView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue, Color.blue.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // App icon/logo placeholder
                Image(systemName: "figure.stand")
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                
                // Main title
                Text("Nutrify")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                // Tagline
                Text("helping you reach maximum height")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Get Started button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        hasCompletedOnboarding = true
                    }
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

#Preview {
    GetStartedView()
}
