//
//  AddEditProfileView.swift
//  SolidAide
//
//  Created by apprenant78 on 04/11/2025.
//

// AddEditProfileView.swift
import SwiftUI

struct AddEditProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ProfileViewModel
    
    private var navigationTitle: String
    
    init() {
        _viewModel = State(initialValue: ProfileViewModel())
        navigationTitle = "Nouveau Profil"
    }
    
    init(profile: ProfileClass) {
        _viewModel = State(initialValue: ProfileViewModel(profile: profile))
        navigationTitle = "Modifier le Profil"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Infos de base") {
                    TextField("Pseudo", text: $viewModel.pseudo)
                    TextField("Ville", text: $viewModel.city)
                    TextField("À propos de moi", text: $viewModel.aboutMe)
                    DatePicker("Anniversaire", selection: $viewModel.birthday, displayedComponents: .date)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
                        viewModel.save(context: modelContext)
                        dismiss()
                    }
                }
            }
            SkillButtonsView()
            
        }
    }
}

#Preview {
    AddEditProfileView()
}
