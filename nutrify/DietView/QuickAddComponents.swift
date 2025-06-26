//
//  QuickAddComponents.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

// Nutrients model
struct Nutrients {
    let protein: Double
    let calcium: Double
    let zinc: Double
//    let vitaminD: Double
    let boron: Double  // was vitaminD
}

// Food types
enum QuickAddFood: String, CaseIterable {
    case redMeat = "Red Meat"
    case eggs = "Eggs"
    case milk = "Milk"
    case yogurt = "Yogurt"
    case almonds = "Almonds"
    case cashews = "Cashews"
    case raisins = "Raisins"
    case avocado = "Avocado"
    case cheese = "Cheese"
    
    var icon: String {
        switch self {
        case .redMeat: return "🥩"
        case .eggs: return "🥚"
        case .milk: return "🥛"
        case .yogurt: return "🥣"
        case .almonds: return "🌰"
        case .cashews: return "🥜"
        case .raisins: return "🍇"
        case .avocado: return "🥑"
        case .cheese: return "🧀"
        }
    }
    
    var portions: [(name: String, nutrients: Nutrients)] {
        switch self {
        case .redMeat:
            return [
                ("3 oz", Nutrients(protein: 22, calcium: 15, zinc: 5.3, boron: 0.0043)),
                ("6 oz", Nutrients(protein: 44, calcium: 30, zinc: 10.6, boron: 0.0086))
            ]
        case .eggs:
            return [
                ("1 large", Nutrients(protein: 6, calcium: 25, zinc: 0.5, boron: 0.12)),
                ("2 large", Nutrients(protein: 12, calcium: 50, zinc: 1.0, boron: 0.24)),
                ("3 large", Nutrients(protein: 18, calcium: 75, zinc: 1.5, boron: 0.36))
            ]
        case .milk:
            return [
                ("1 cup", Nutrients(protein: 8, calcium: 300, zinc: 1.0, boron: 0.055)),
                ("2 cups", Nutrients(protein: 16, calcium: 600, zinc: 2.0, boron: 0.11))
            ]
        case .yogurt:
            return [
                ("1 cup", Nutrients(protein: 10, calcium: 450, zinc: 1.7, boron: 0.001)),
                ("½ cup", Nutrients(protein: 5, calcium: 225, zinc: 0.85, boron: 0.0005))
            ]
        case .almonds:
            return [
                ("1 oz", Nutrients(protein: 6, calcium: 75, zinc: 0.9, boron: 1.5792)),
                ("¼ cup", Nutrients(protein: 7.5, calcium: 94, zinc: 1.1, boron: 1.974))
            ]
        case .cashews:
            return [
                ("1 oz", Nutrients(protein: 5, calcium: 10, zinc: 1.6, boron: 0.326)),
                ("¼ cup", Nutrients(protein: 6.25, calcium: 12.5, zinc: 2.0, boron: 0.374))
            ]
        case .raisins:
            return [
                ("¼ cup", Nutrients(protein: 1, calcium: 20, zinc: 0.1, boron: 0.95)),
                ("½ cup", Nutrients(protein: 2, calcium: 40, zinc: 0.2, boron: 1.9))
            ]
        case .avocado:
            return [
                ("½ avocado", Nutrients(protein: 2, calcium: 12, zinc: 0.6, boron: 0.642)),
                ("1 avocado", Nutrients(protein: 4, calcium: 24, zinc: 1.2, boron: 1.284))
            ]
        case .cheese:
            return [
                ("1 oz", Nutrients(protein: 7, calcium: 200, zinc: 0.9, boron: 0.0054)),
                ("2 oz", Nutrients(protein: 14, calcium: 400, zinc: 1.8, boron: 0.0108))
            ]
        }
    }
}

// Quick add button
struct QuickAddButton: View {
    let food: QuickAddFood
    let onAdd: (Nutrients) -> Void
    @State private var showingPortions = false
    
    var body: some View {
        Button(action: { showingPortions = true }) {
            VStack(spacing: 8) {
                Text(food.icon)
                    .font(.title)
                Text(food.rawValue)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .sheet(isPresented: $showingPortions) {
            PortionSelectorView(food: food) { nutrients in
                onAdd(nutrients)
                showingPortions = false
            }
        }
    }
}

// Portion selector
struct PortionSelectorView: View {
    let food: QuickAddFood
    let onSelect: (Nutrients) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Food header
                VStack(spacing: 10) {
                    Text(food.icon)
                        .font(.system(size: 60))
                    Text(food.rawValue)
                        .font(.title2.bold())
                }
                .padding(.vertical, 30)
                
                // Portion options
                VStack(spacing: 12) {
                    ForEach(food.portions.indices, id: \.self) { index in
                        let portion = food.portions[index]
                        Button(action: { onSelect(portion.nutrients) }) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(portion.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                HStack(spacing: 15) {
                                    NutrientLabel("P", value: portion.nutrients.protein, unit: "g", color: .red)
                                    NutrientLabel("Ca", value: portion.nutrients.calcium, unit: "mg", color: .green)
                                    NutrientLabel("Zn", value: portion.nutrients.zinc, unit: "mg", color: .purple)
                                    NutrientLabel("B", value: portion.nutrients.boron, unit: "mg", color: .orange)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Select Portion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct NutrientLabel: View {
    let label: String
    let value: Double
    let unit: String
    let color: Color
    
    init(_ label: String, value: Double, unit: String, color: Color) {
        self.label = label
        self.value = value
        self.unit = unit
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(String(format: "%.1f", value))
                .font(.subheadline.bold())
                .foregroundStyle(color)
        }
    }
}
