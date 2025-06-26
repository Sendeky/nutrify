//
//  SourcesView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/26/25.
//

import SwiftUI

struct SourcesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Nutrition Sources
                VStack(alignment: .leading, spacing: 12) {
                    Label("Nutrition Data", systemImage: "fork.knife")
                        .font(.headline)
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• USDA FoodData Central")
                            .font(.subheadline)
                        Text("Primary source for protein, calcium, and zinc values")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• WHO/IPCS Environmental Health Criteria")
                            .font(.subheadline)
                        Text("Boron content data via GreenFacts.org")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• National Institutes of Health (NIH)")
                            .font(.subheadline)
                        Text("Recommended daily intake values")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Exercise Sources
                VStack(alignment: .leading, spacing: 12) {
                    Label("Exercise Research", systemImage: "figure.run")
                        .font(.headline)
                        .foregroundStyle(.green)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Journal of Bone and Mineral Research")
                            .font(.subheadline)
                        Text("Studies on mechanical loading and bone growth")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• International Journal of Sports Medicine")
                            .font(.subheadline)
                        Text("Swimming and spinal decompression research")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• Growth Hormone & IGF Research Journal")
                            .font(.subheadline)
                        Text("Exercise-induced growth hormone release")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Sleep Sources
                VStack(alignment: .leading, spacing: 12) {
                    Label("Sleep Science", systemImage: "moon.zzz.fill")
                        .font(.headline)
                        .foregroundStyle(.indigo)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Sleep Medicine Reviews")
                            .font(.subheadline)
                        Text("HGH secretion during deep sleep phases")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• Journal of Clinical Endocrinology")
                            .font(.subheadline)
                        Text("Sleep duration and growth hormone levels")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("• National Sleep Foundation")
                            .font(.subheadline)
                        Text("Age-based sleep recommendations")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // Note
                Text("Note: This app synthesizes publicly available research. Always consult healthcare professionals for personalized advice.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(Color(.systemBlue).opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
        }
        .navigationTitle("Sources")
        .navigationBarTitleDisplayMode(.large)
    }
}
#Preview {
    SourcesView()
}
