//
//  DisclaimerView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Medical Disclaimer
                VStack(alignment: .leading, spacing: 12) {
                    Label("Medical Disclaimer", systemImage: "exclamationmark.triangle.fill")
                        .font(.headline)
                        .foregroundStyle(.orange)
                    
                    Text("""
                    This app is for informational purposes only and is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding growth, nutrition, or exercise.
                    
                    Never disregard professional medical advice or delay in seeking it because of something you have read in this app.
                    """)
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemOrange).opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Age Considerations
                VStack(alignment: .leading, spacing: 12) {
                    Label("Age Considerations", systemImage: "person.2.fill")
                        .font(.headline)
                        .foregroundStyle(.blue)
                    
                    Text("""
                    • Growth potential varies significantly by age
                    • Most height growth occurs before growth plates close (typically 14-19 for girls, 16-21 for boys)
                    • Adults can still improve posture and spinal health
                    • Consult a pediatrician for users under 18
                    """)
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Exercise Safety
                VStack(alignment: .leading, spacing: 12) {
                    Label("Exercise Safety", systemImage: "figure.strengthtraining.traditional")
                        .font(.headline)
                        .foregroundStyle(.green)
                    
                    Text("""
                    • Start slowly and gradually increase intensity
                    • Stop immediately if you experience pain
                    • Hanging exercises should not cause shoulder pain
                    • Swimming requires proper supervision if not proficient
                    • Warm up before stretching
                    """)
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Supplement Warning
                VStack(alignment: .leading, spacing: 12) {
                    Label("Nutrition & Supplements", systemImage: "pills.fill")
                        .font(.headline)
                        .foregroundStyle(.purple)
                    
                    Text("""
                    • Nutrient targets are general guidelines
                    • Individual needs vary based on age, sex, and health
                    • Excessive supplementation can be harmful
                    • Obtain nutrients from food when possible
                    • Consult a healthcare provider before taking supplements
                    """)
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Legal
                Text("By using this app, you acknowledge that you have read and understood this disclaimer and agree to its terms.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Health Disclaimer")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    DisclaimerView()
}
