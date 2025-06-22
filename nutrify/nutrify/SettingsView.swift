//
//  SettingsView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("userAge") var userAge = 0
    @AppStorage("userWeight") var userWeight = 0.0
    @AppStorage("userHeightFeet") var userHeightFeet = 0
    @AppStorage("userHeightInches") var userHeightInches = 0
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = true
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = true
    
    @State private var age = ""
    @State private var weight = ""
    @State private var feet = ""
    @State private var inches = ""
    @State private var isEditing = false
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Profile Section
                Section("Profile") {
                    HStack {
                        Text("Age")
                        Spacer()
                        if isEditing {
                            TextField("Age", text: $age)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 60)
                        } else {
                            Text("\(userAge)")
                                .foregroundStyle(.secondary)
                        }
                        Text("years")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Weight")
                        Spacer()
                        if isEditing {
                            TextField("Weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 80)
                        } else {
                            Text(String(format: "%.1f", userWeight))
                                .foregroundStyle(.secondary)
                        }
                        Text("lbs")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Height")
                        Spacer()
                        if isEditing {
                            HStack(spacing: 5) {
                                TextField("Feet", text: $feet)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 40)
                                Text("'")
                                    .foregroundStyle(.secondary)
                                TextField("Inches", text: $inches)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 40)
                                Text("\"")
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text("\(userHeightFeet)' \(userHeightInches)\"")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Goals Section (for future expansion)
                Section("Goals") {
                    HStack {
                        Text("Target Height Gain")
                        Spacer()
                        Text("Coming Soon")
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Daily Reminders")
                        Spacer()
                        Toggle("", isOn: .constant(false))
                            .disabled(true)
                    }
                }
                
                // App Section
                Section("App") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    
                    Button(action: {
                        showingResetAlert = true
                    }) {
                        Text("Reset App")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        if isEditing {
                            saveChanges()
                        } else {
                            startEditing()
                        }
                        isEditing.toggle()
                    }
                }
            }
            .alert("Reset App", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    resetApp()
                }
            } message: {
                Text("This will clear all your data and return to the welcome screen. This action cannot be undone.")
            }
        }
    }
    
    private func startEditing() {
        age = String(userAge)
        weight = String(format: "%.1f", userWeight)
        feet = String(userHeightFeet)
        inches = String(userHeightInches)
    }
    
    private func saveChanges() {
        // Validate and save
        if let ageInt = Int(age), ageInt > 0 {
            userAge = ageInt
        }
        if let weightDouble = Double(weight), weightDouble > 0 {
            userWeight = weightDouble
        }
        if let feetInt = Int(feet), feetInt >= 0 {
            userHeightFeet = feetInt
        }
        if let inchesInt = Int(inches), inchesInt >= 0 && inchesInt < 12 {
            userHeightInches = inchesInt
        }
    }
    
    private func resetApp() {
        // Clear all user defaults
        hasCompletedOnboarding = false
        hasCompletedSetup = false
        userAge = 0
        userWeight = 0.0
        userHeightFeet = 0
        userHeightInches = 0
    }
}

#Preview {
    SettingsView()
}
