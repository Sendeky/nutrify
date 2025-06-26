//
//  AddExerciseView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

import SwiftUI

struct AddExerciseView: View {
    let type: ExerciseType
    let onComplete: (Bool) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var duration = 0
    @State private var sets = 1
    @State private var notes = ""
    @State private var showingTimer = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Exercise header
                VStack(spacing: 10) {
                    Text(type.icon)
                        .font(.system(size: 60))
                    Text(type.rawValue)
                        .font(.title2.bold())
                    Text(type.recommendedDuration)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 30)
                
                // Input form
                Form {
                    Section("Session Details") {
                        if type == .hanging {
                            Stepper("Sets: \(sets)", value: $sets, in: 1...10)
                            
                            HStack {
                                Text("Duration per set")
                                Spacer()
                                Text("\(duration) seconds")
                                    .foregroundStyle(.secondary)
                            }
                            .onTapGesture {
                                showingTimer = true
                            }
                        } else {
                            HStack {
                                Text("Duration")
                                Spacer()
                                Text("\(duration) minutes")
                                    .foregroundStyle(.secondary)
                            }
                            
                            Slider(value: Binding(
                                get: { Double(duration) },
                                set: { duration = Int($0) }
                            ), in: 5...120, step: 5)
                        }
                    }
                    
                    Section("Notes (Optional)") {
                        TextField("How did it go?", text: $notes, axis: .vertical)
                            .lineLimit(3...6)
                    }
                }
                
                // Complete button
                Button(action: {
                    onComplete(true)
                    dismiss()
                }) {
                    Text("Complete Exercise")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .disabled(type == .hanging ? duration == 0 : duration < 5)
            }
            .navigationTitle("Log Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showingTimer) {
                HangingTimerView(duration: $duration)
            }
        }
    }
}

// Hanging timer view
struct HangingTimerView: View {
    @Binding var duration: Int
    @Environment(\.dismiss) var dismiss
    
    @State private var timeElapsed = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                // Timer display
                Text(String(format: "%02d:%02d", timeElapsed / 60, timeElapsed % 60))
                    .font(.system(size: 72, weight: .thin, design: .monospaced))
                    .foregroundStyle(.primary)
                
                // Start/Stop button
                Button(action: toggleTimer) {
                    Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(isRunning ? .orange : .green)
                }
                
                // Reset button
                if timeElapsed > 0 && !isRunning {
                    Button(action: {
                        timeElapsed = 0
                    }) {
                        Text("Reset")
                            .font(.headline)
                            .foregroundStyle(.red)
                    }
                }
                
                Spacer()
                
                // Save button
                Button(action: {
                    duration = timeElapsed
                    dismiss()
                }) {
                    Text("Save Duration")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 40)
                .disabled(timeElapsed == 0)
            }
            .navigationTitle("Hanging Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func toggleTimer() {
        isRunning.toggle()
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                timeElapsed += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
}
