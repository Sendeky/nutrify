//
//  ExerciseView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

struct ExerciseView: View {
    @AppStorage("exerciseStreak") var exerciseStreak = 0
    @AppStorage("lastExerciseDate") var lastExerciseDate = ""
    
    // Persist exercise completion status
    @AppStorage("todayHanging") var todayHanging = false
    @AppStorage("todayStretching") var todayStretching = false
    @AppStorage("todaySwimming") var todaySwimming = false
    @AppStorage("exerciseDataDate") var exerciseDataDate = ""
    
    @State private var showingAddExercise = false
    @State private var selectedExerciseType: ExerciseType?
    
    var todaysExercises: [ExerciseType: Bool] {
        [
            .hanging: todayHanging,
            .stretching: todayStretching,
            .swimming: todaySwimming
        ]
    }
    
    var allExercisesComplete: Bool {
        todaysExercises.values.allSatisfy { $0 == true }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Streak indicator
                    ExerciseStreakView(streak: exerciseStreak, allComplete: allExercisesComplete)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Today's exercises
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Today's Exercises")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(ExerciseType.allCases, id: \.self) { exercise in
                                ExerciseCard(
                                    type: exercise,
                                    isCompleted: todaysExercises[exercise] ?? false,
                                    onTap: {
                                        if !(todaysExercises[exercise] ?? false) {
                                            selectedExerciseType = exercise
                                            showingAddExercise = true
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Quick tips section
                    TipsSection()
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationTitle("Exercise")
            .sheet(isPresented: $showingAddExercise) {
                if let exerciseType = selectedExerciseType {
                    AddExerciseView(type: exerciseType) { completed in
                        if completed {
                            withAnimation {
                                switch exerciseType {
                                case .hanging:
                                    todayHanging = true
                                case .stretching:
                                    todayStretching = true
                                case .swimming:
                                    todaySwimming = true
                                }
                                checkStreakStatus()
                            }
                        }
                    }
                }
            }
            .onAppear {
                loadTodaysProgress()
            }
        }
    }
    
    private func loadTodaysProgress() {
        let today = DateFormatter.dateOnly.string(from: Date())
        
        // Reset if it's a new day
        if exerciseDataDate != today {
            todayHanging = false
            todayStretching = false
            todaySwimming = false
            exerciseDataDate = today
            
            // Check if streak should be reset
            if let lastDate = DateFormatter.dateOnly.date(from: lastExerciseDate),
               Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0 > 1 {
                exerciseStreak = 0
            }
        }
    }
    
    private func checkStreakStatus() {
        guard allExercisesComplete else { return }
        
        let today = DateFormatter.dateOnly.string(from: Date())
        if lastExerciseDate != today {
            exerciseStreak += 1
            lastExerciseDate = today
        }
    }
}

// Exercise types
enum ExerciseType: String, CaseIterable {
    case hanging = "Hanging"
    case stretching = "Stretching"
    case swimming = "Swimming"
    
    var icon: String {
        switch self {
        case .hanging: return "🙌"
        case .stretching: return "🧘"
        case .swimming: return "🏊"
        }
    }
    
    var description: String {
        switch self {
        case .hanging:
            return "Decompresses spine and promotes growth"
        case .stretching:
            return "Improves posture and flexibility"
        case .swimming:
            return "Full body exercise that lengthens muscles"
        }
    }
    
    var recommendedDuration: String {
        switch self {
        case .hanging:
            return "3 sets × 30-60 seconds"
        case .stretching:
            return "15-20 minutes"
        case .swimming:
            return "30-45 minutes"
        }
    }
}

// Exercise streak view
struct ExerciseStreakView: View {
    let streak: Int
    let allComplete: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundStyle(streak > 0 ? .orange : .gray)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(streak) day streak")
                    .font(.headline)
                Text(allComplete ? "All exercises complete! 💪" : "Complete all exercises to continue streak")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// Exercise card component
struct ExerciseCard: View {
    let type: ExerciseType
    let isCompleted: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(type.icon)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(type.rawValue)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(type.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(type.recommendedDuration)
                        .font(.caption2)
                        .foregroundStyle(.blue)
                }
                
                Spacer()
                
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isCompleted ? .green : .gray)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isCompleted)
    }
}

// Tips section
struct TipsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Pro Tips")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Label("Hang with relaxed shoulders", systemImage: "lightbulb.fill")
                    .font(.caption)
                Label("Stretch after warm shower for flexibility", systemImage: "lightbulb.fill")
                    .font(.caption)
                Label("Swimming backstroke is best for spine", systemImage: "lightbulb.fill")
                    .font(.caption)
            }
            .padding()
            .background(Color(.systemBlue).opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    ExerciseView()
}
