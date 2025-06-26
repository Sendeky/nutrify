//
//  RecoveryView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

struct RecoveryView: View {
    @AppStorage("sleepStreak") var sleepStreak = 0
    @AppStorage("lastSleepDate") var lastSleepDate = ""
    @AppStorage("lastNightSleepHours") var lastNightSleepHours: Double = 0
    @AppStorage("lastSleepQuality") var lastSleepQualityRaw = "good"
    
    @State private var showingAddSleep = false
    @State private var todayLogged = false
    
    var lastSleepQuality: SleepQuality {
        SleepQuality(rawValue: lastSleepQualityRaw) ?? .good
    }
    
    let targetSleepHours: Double = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Sleep streak
                    SleepStreakView(
                        streak: sleepStreak,
                        targetMet: lastNightSleepHours >= targetSleepHours,
                        hoursSlept: lastNightSleepHours
                    )
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Sleep rings visualization
                    SleepRingsView(
                        currentHours: lastNightSleepHours,
                        targetHours: targetSleepHours,
                        quality: lastSleepQuality
                    )
                    .padding(.horizontal)
                    
                    // Log sleep button
                    if !todayLogged {
                        Button(action: { showingAddSleep = true }) {
                            Label("Log Last Night's Sleep", systemImage: "moon.zzz.fill")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.indigo)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal)
                    }
                    
                    // Sleep tips
                    SleepTipsView()
                        .padding(.horizontal)
                    
                    // Recovery checklist
                    RecoveryChecklistView()
                        .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationTitle("Recovery")
            .sheet(isPresented: $showingAddSleep) {
                LogSleepView { hours, quality in
                    lastNightSleepHours = hours
                    lastSleepQualityRaw = quality.rawValue
                    todayLogged = true
                    updateStreak()
                }
            }
            .onAppear {
                checkTodayStatus()
            }
        }
    }
    
    private func checkTodayStatus() {
        let today = DateFormatter.dateOnly.string(from: Date())
        if lastSleepDate == today {
            todayLogged = true
        } else {
            todayLogged = false
            // Check if streak should be reset
            if let lastDate = DateFormatter.dateOnly.date(from: lastSleepDate),
               Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0 > 1 {
                sleepStreak = 0
            }
        }
    }
    
    private func updateStreak() {
        let today = DateFormatter.dateOnly.string(from: Date())
        if lastNightSleepHours >= targetSleepHours && lastSleepDate != today {
            sleepStreak += 1
            lastSleepDate = today
        }
    }
}

// Sleep quality enum
enum SleepQuality: String, CaseIterable {
    case poor = "Poor"
    case fair = "Fair"
    case good = "Good"
    case excellent = "Excellent"
    
    var color: Color {
        switch self {
        case .poor: return .red
        case .fair: return .orange
        case .good: return .green
        case .excellent: return .blue
        }
    }
    
    var emoji: String {
        switch self {
        case .poor: return "😴"
        case .fair: return "😐"
        case .good: return "😊"
        case .excellent: return "😄"
        }
    }
}

// Sleep streak view
struct SleepStreakView: View {
    let streak: Int
    let targetMet: Bool
    let hoursSlept: Double
    
    var body: some View {
        HStack {
            Image(systemName: "moon.stars.fill")
                .font(.title2)
                .foregroundStyle(streak > 0 ? .indigo : .gray)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(streak) night streak")
                    .font(.headline)
                if hoursSlept > 0 {
                    Text(String(format: "%.1f hours last night", hoursSlept))
                        .font(.caption)
                        .foregroundStyle(targetMet ? .green : .orange)
                } else {
                    Text("Log your sleep to start tracking")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// Sleep rings visualization
struct SleepRingsView: View {
    let currentHours: Double
    let targetHours: Double
    let quality: SleepQuality
    
    var progress: Double {
        min(currentHours / targetHours, 1.0)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Background ring
                Circle()
                    .stroke(Color.indigo.opacity(0.2), lineWidth: 30)
                    .frame(width: 180, height: 180)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.indigo,
                        style: StrokeStyle(lineWidth: 30, lineCap: .round)
                    )
                    .frame(width: 180, height: 180)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: progress)
                
                // Center content
                VStack(spacing: 5) {
                    Text(String(format: "%.1f", currentHours))
                        .font(.system(size: 48, weight: .bold))
                    Text("hours")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    if currentHours > 0 {
                        Text(quality.emoji)
                            .font(.title2)
                    }
                }
            }
            
            // Target indicator
            HStack {
                Image(systemName: "target")
                Text("Goal: \(Int(targetHours))+ hours for optimal growth")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// Sleep tips
struct SleepTipsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sleep Tips for Growth")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                TipRow(icon: "moon.zzz", tip: "Sleep 8-10 hours for maximum HGH release")
                TipRow(icon: "iphone.slash", tip: "No screens 1 hour before bed")
                TipRow(icon: "thermometer.medium", tip: "Keep room cool (65-68°F)")
                TipRow(icon: "moon.haze", tip: "Complete darkness for deep sleep")
            }
            .padding()
            .background(Color(.systemIndigo).opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct TipRow: View {
    let icon: String
    let tip: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.indigo)
                .frame(width: 24)
            Text(tip)
                .font(.caption)
        }
    }
}

// Recovery checklist
struct RecoveryChecklistView: View {
    @State private var checklist = [
        ChecklistItem(id: 0, title: "Morning stretch", isChecked: false),
        ChecklistItem(id: 1, title: "Hydrated well", isChecked: false),
        ChecklistItem(id: 2, title: "Avoided heavy lifting", isChecked: false),
        ChecklistItem(id: 3, title: "Good posture today", isChecked: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recovery Checklist")
                .font(.headline)
            
            VStack(spacing: 8) {
                ForEach($checklist) { $item in
                    HStack {
                        Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(item.isChecked ? .green : .gray)
                            .onTapGesture {
                                withAnimation {
                                    item.isChecked.toggle()
                                }
                            }
                        
                        Text(item.title)
                            .font(.subheadline)
                            .strikethrough(item.isChecked)
                            .foregroundStyle(item.isChecked ? .secondary : .primary)
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct ChecklistItem: Identifiable {
    let id: Int
    let title: String
    var isChecked: Bool
}

#Preview {
    RecoveryView()
}
