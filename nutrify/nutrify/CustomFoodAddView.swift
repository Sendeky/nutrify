//
//  CustomFoodAddView.swift
//  nutrify
//
//  Created by Ruslan Spirkin on 6/21/25.
//

import SwiftUI

struct CustomFoodAddView: View {
    let onAdd: (Nutrients) -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var foodName = ""
    @State private var protein = ""
    @State private var calcium = ""
    @State private var zinc = ""
    @State private var vitaminD = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, protein, calcium, zinc, vitaminD
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Food Info") {
                    TextField("Food name", text: $foodName)
                        .focused($focusedField, equals: .name)
                }
                
                Section("Nutrients") {
                    HStack {
                        Label("Protein", systemImage: "circle.fill")
                            .foregroundStyle(.red)
                        Spacer()
                        TextField("0.0", text: $protein)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .protein)
                            .frame(width: 80)
                        Text("g")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Label("Calcium", systemImage: "circle.fill")
                            .foregroundStyle(.green)
                        Spacer()
                        TextField("0.0", text: $calcium)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .calcium)
                            .frame(width: 80)
                        Text("mg")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Label("Zinc", systemImage: "circle.fill")
                            .foregroundStyle(.purple)
                        Spacer()
                        TextField("0.0", text: $zinc)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .zinc)
                            .frame(width: 80)
                        Text("mg")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Label("Vitamin D", systemImage: "circle.fill")
                            .foregroundStyle(.orange)
                        Spacer()
                        TextField("0.0", text: $vitaminD)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .vitaminD)
                            .frame(width: 80)
                        Text("IU")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Add Custom Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addFood()
                    }
                    .fontWeight(.semibold)
                    .disabled(foodName.isEmpty)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    }
    
    private func addFood() {
        let nutrients = Nutrients(
            protein: Double(protein) ?? 0,
            calcium: Double(calcium) ?? 0,
            zinc: Double(zinc) ?? 0,
            vitaminD: Double(vitaminD) ?? 0
        )
        onAdd(nutrients)
        dismiss()
    }
}
