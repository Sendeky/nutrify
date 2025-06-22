//
//  DietView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct DietView: View {
    @AppStorage("currentStreak") var currentStreak = 0
    @AppStorage("lastCompletedDate") var lastCompletedDate = ""
    
    @State private var proteinGrams: Double = 0
    @State private var calciumMg: Double = 0
    @State private var zincMg: Double = 0
    @State private var vitaminDIU: Double = 0
    @State private var showingCustomAdd = false
    
    // Daily targets
    let proteinTarget: Double = 100
    let calciumTarget: Double = 1000
    let zincTarget: Double = 10
    let vitaminDTarget: Double = 600
    
    var allGoalsComplete: Bool {
        proteinGrams >= proteinTarget &&
        calciumMg >= calciumTarget &&
        zincMg >= zincTarget &&
        vitaminDIU >= vitaminDTarget
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Streak indicator
                    StreakView(streak: currentStreak, allGoalsComplete: allGoalsComplete)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Nutrient rings
                    NutrientRingsView(
                        protein: proteinGrams,
                        proteinTarget: proteinTarget,
                        calcium: calciumMg,
                        calciumTarget: calciumTarget,
                        zinc: zincMg,
                        zincTarget: zincTarget,
                        vitaminD: vitaminDIU,
                        vitaminDTarget: vitaminDTarget
                    )
                    .padding(.horizontal)
                    
                    // Quick add section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Quick Add")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            // Quick add foods
                            QuickAddButton(food: .redMeat) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .eggs) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .milk) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .yogurt) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .almonds) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .cashews) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .raisins) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .avocado) { nutrients in
                                addNutrients(nutrients)
                            }
                            QuickAddButton(food: .cheese) { nutrients in
                                addNutrients(nutrients)
                            }
                            
                            // Custom add button
                            Button(action: { showingCustomAdd = true }) {
                                VStack(spacing: 8) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(.blue)
                                    Text("Custom")
                                        .font(.caption)
                                        .foregroundStyle(.primary)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 30)
                }
            }
            .navigationTitle("Diet")
            .sheet(isPresented: $showingCustomAdd) {
                CustomFoodAddView { nutrients in
                    addNutrients(nutrients)
                }
            }
            .onAppear {
                checkStreakStatus()
            }
        }
    }
    
    private func addNutrients(_ nutrients: Nutrients) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            proteinGrams += nutrients.protein
            calciumMg += nutrients.calcium
            zincMg += nutrients.zinc
            vitaminDIU += nutrients.vitaminD
        }
        
        checkGoalsAndUpdateStreak()
    }
    
    private func checkStreakStatus() {
        let today = DateFormatter.dateOnly.string(from: Date())
        if lastCompletedDate != today && !allGoalsComplete {
            // Check if we need to reset streak (missed a day)
            if let lastDate = DateFormatter.dateOnly.date(from: lastCompletedDate),
               Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0 > 1 {
                currentStreak = 0
            }
        }
    }
    
    private func checkGoalsAndUpdateStreak() {
        guard allGoalsComplete else { return }
        
        let today = DateFormatter.dateOnly.string(from: Date())
        if lastCompletedDate != today {
            currentStreak += 1
            lastCompletedDate = today
        }
    }
}

// Streak view component
struct StreakView: View {
    let streak: Int
    let allGoalsComplete: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundStyle(streak > 0 ? .orange : .gray)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(streak) day streak")
                    .font(.headline)
                Text(allGoalsComplete ? "All goals complete! 🎉" : "Complete all rings to continue streak")
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

// Date formatter extension
extension DateFormatter {
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

#Preview {
    DietView()
}
