//
//  ServiceEditView.swift
//  SolidAide
//
//  Created by apprenant78 on 02/11/2025.
//

import SwiftUI
import SwiftData

struct ServiceEditView: View {
    @State var viewModel: ServiceFormViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
//    @Query private var allProfiles: [ProfileClass]

    var body: some View {
        NavigationStack {
            Form {
                Section("Détails de la demande") {
                    Picker("Compétence", selection: $viewModel.skill) {
                        ForEach(SkillsEnum.allCases, id: \.self) { skill in
                            HStack {
                            Image(systemName: skill.icon)
                            Text(skill.rawValue)
                            }
                        }
                    }
                    
                    
                    TextField("Description", text: $viewModel.serviceDescription, axis: .vertical)
                        .lineLimit(3...)

                    TextField("Ville", text: $viewModel.city)

                }

                Section("Conditions") {
                    Toggle("Gratuit", isOn: $viewModel.isFree)
                    
                    Stepper("Temps (heures): \(viewModel.timeSpent)", value: $viewModel.timeSpent, in: 1...24, step: 1)

                    DatePicker("Date de début", selection: $viewModel.startDate, displayedComponents: [.date, .hourAndMinute])
                }

            }
            .navigationTitle(viewModel.isEditing ? "Modifier la demande" : "Nouvel Demande")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        /// (C)REATE / (U)PDATE Action
                        viewModel.save(context: context)
                        dismiss()
                    }
                    .disabled(!viewModel.canSave)
                }
            }
        }
    }
}


#Preview {
    ServiceEditView(viewModel: ServiceFormViewModel())
        .modelContainer(for: [ServiceClass.self, ProfileClass.self], inMemory: true)
}

