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
    
    // Le ViewModel gère l'état du formulaire
    @State private var viewModel: ProfileViewModel
    
    // Détermine le titre de la vue
    private var navigationTitle: String
    
    // Initialiseur pour le mode "Création"
    init() {
        _viewModel = State(initialValue: ProfileViewModel())
        navigationTitle = "Nouveau Profil"
    }
    
    // Initialiseur pour le mode "Modification"
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
                
//                Section("Localisation (Optionnel)") {
//                    TextField("Latitude", text: $viewModel.latitudeString)
//                        .keyboardType(.decimalPad)
//                    TextField("Longitude", text: $viewModel.longitudeString)
//                        .keyboardType(.decimalPad)
//                }
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
                        // Le ViewModel gère la logique de création ou de MAJ
                        viewModel.save(context: modelContext)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddEditProfileView()
}
