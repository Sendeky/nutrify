//
//  SetupView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct SetupView: View {
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = false
    @AppStorage("userAge") var userAge = 0
    @AppStorage("userWeight") var userWeight = 0.0
    @AppStorage("userHeightFeet") var userHeightFeet = 0
    @AppStorage("userHeightInches") var userHeightInches = 0
    
    @State private var age = ""
    @State private var weight = ""
    @State private var feet = ""
    @State private var inches = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Blue header
                    ZStack {
                        Color.blue
                            .ignoresSafeArea(edges: .top)
                        
                        VStack(spacing: 10) {
                            Text("Setup")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                            
                            Text("Let's get some basic info to personalize your experience")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 30)
                    }
                    .frame(height: 180)
                    
                    // Form
                    Form {
                        Section {
                            HStack {
                                Text("Age")
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter your age", text: $age)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Weight")
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter weight", text: $weight)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                Text("lbs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            HStack {
                                Text("Height")
                                    .frame(width: 100, alignment: .leading)
                                HStack {
                                    TextField("Feet", text: $feet)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 60)
                                    Text("ft")
                                        .foregroundStyle(.secondary)
                                    
                                    TextField("Inches", text: $inches)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 60)
                                    Text("in")
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                    
                    // Continue button
                    Button(action: continueButtonTapped) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
            .alert("Missing Information", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please fill in all fields")
            }
        }
    }
    
    private func continueButtonTapped() {
        // Validate inputs
        guard let ageInt = Int(age), ageInt > 0,
              let weightDouble = Double(weight), weightDouble > 0,
              let feetInt = Int(feet), feetInt >= 0,
              let inchesInt = Int(inches), inchesInt >= 0 && inchesInt < 12 else {
            showingAlert = true
            return
        }
        
        // Save to AppStorage
        userAge = ageInt
        userWeight = weightDouble
        userHeightFeet = feetInt
        userHeightInches = inchesInt
        
        // Mark setup as complete
        withAnimation(.easeInOut(duration: 0.3)) {
            hasCompletedSetup = true
        }
    }
}

#Preview {
    SetupView()
}
