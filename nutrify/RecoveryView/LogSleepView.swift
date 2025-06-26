//
//  LogSleepView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

struct LogSleepView: View {
    let onComplete: (Double, SleepQuality) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var bedtime = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var wakeTime = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var quality: SleepQuality = .good
    
    var sleepDuration: Double {
        let interval = wakeTime.timeIntervalSince(bedtime)
        let hours = interval > 0 ? interval / 3600 : (interval + 86400) / 3600
        return max(0, min(hours, 24)) // Clamp between 0-24 hours
    }
    
    var sleepDurationFormatted: String {
        let hours = Int(sleepDuration)
        let minutes = Int((sleepDuration - Double(hours)) * 60)
        return "\(hours)h \(minutes)m"
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 10) {
                    Image(systemName: "moon.zzz.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.indigo)
                    
                    Text("Log Your Sleep")
                        .font(.title2.bold())
                    
                    Text(sleepDurationFormatted)
                        .font(.title3)
                        .foregroundStyle(sleepDuration >= 8 ? .green : .orange)
                }
                .padding(.vertical, 30)
                
                // Form
                Form {
                    Section("Sleep Times") {
                        DatePicker(
                            "Bedtime",
                            selection: $bedtime,
                            displayedComponents: .hourAndMinute
                        )
                        
                        DatePicker(
                            "Wake Time",
                            selection: $wakeTime,
                            displayedComponents: .hourAndMinute
                        )
                    }
                    
                    Section("Sleep Quality") {
                        Picker("How did you sleep?", selection: $quality) {
                            ForEach(SleepQuality.allCases, id: \.self) { quality in
                                Text(quality.emoji)
                                    .tag(quality)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundStyle(.blue)
                                Text("Sleep Facts")
                                    .font(.subheadline.bold())
                            }
                            
                            Text("• Growth hormone is released during deep sleep")
                                .font(.caption)
                            Text("• 8-10 hours optimizes height growth")
                                .font(.caption)
                            Text("• Consistent sleep schedule improves quality")
                                .font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                // Save button
                Button(action: {
                    onComplete(sleepDuration, quality)
                    dismiss()
                }) {
                    Text("Save Sleep Data")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Sleep Tracking")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
