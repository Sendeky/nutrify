//
//  NutrientRingsView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct NutrientRingsView: View {
    let protein: Double
    let proteinTarget: Double
    let calcium: Double
    let calciumTarget: Double
    let zinc: Double
    let zincTarget: Double
    let vitaminD: Double
    let vitaminDTarget: Double
    
    var body: some View {
        VStack(spacing: 20) {
            // Main rings display
            ZStack {
                // Vitamin D - Outermost ring
                RingView(
                    progress: min(vitaminD / vitaminDTarget, 1.0),
                    color: .orange,
                    lineWidth: 20,
                    radius: 85
                )
                
                // Zinc - Third ring
                RingView(
                    progress: min(zinc / zincTarget, 1.0),
                    color: .purple,
                    lineWidth: 20,
                    radius: 65
                )
                
                // Calcium - Second ring
                RingView(
                    progress: min(calcium / calciumTarget, 1.0),
                    color: .green,
                    lineWidth: 20,
                    radius: 45
                )
                
                // Protein - Innermost ring
                RingView(
                    progress: min(protein / proteinTarget, 1.0),
                    color: .red,
                    lineWidth: 20,
                    radius: 25
                )
            }
            .frame(height: 200)
            
            // Legend
            VStack(spacing: 12) {
                NutrientRow(
                    name: "Protein",
                    current: protein,
                    target: proteinTarget,
                    unit: "g",
                    color: .red
                )
                NutrientRow(
                    name: "Calcium",
                    current: calcium,
                    target: calciumTarget,
                    unit: "mg",
                    color: .green
                )
                NutrientRow(
                    name: "Zinc",
                    current: zinc,
                    target: zincTarget,
                    unit: "mg",
                    color: .purple
                )
                NutrientRow(
                    name: "Vitamin D",
                    current: vitaminD,
                    target: vitaminDTarget,
                    unit: "IU",
                    color: .orange
                )
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct RingView: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat
    let radius: CGFloat
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(color.opacity(0.2), lineWidth: lineWidth)
                .frame(width: radius * 2, height: radius * 2)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: progress)
        }
    }
}

struct NutrientRow: View {
    let name: String
    let current: Double
    let target: Double
    let unit: String
    let color: Color
    
    var progress: Double {
        min(current / target, 1.0)
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            Text(name)
                .font(.subheadline)
            
            Spacer()
            
            Text("\(String(format: "%.1f", current)) / \(String(format: "%.0f", target)) \(unit)")
                .font(.subheadline)
                .foregroundStyle(progress >= 1.0 ? .green : .secondary)
        }
    }
}
