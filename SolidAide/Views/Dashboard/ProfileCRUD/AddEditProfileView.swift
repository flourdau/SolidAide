import SwiftUI
import SwiftData

struct AddEditProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ProfileViewModel
    private let navTitle: String

    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
        navTitle = "Nouveau Profil"
    }

    init(profile: ProfileClass) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(profile: profile))
        navTitle = "Modifier le Profil"
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

                Section("Compétences") {
                    SkillSelector(selected: $viewModel.selectedSkills, editable: true)
                        .frame(height: 130)
                }

                Section("Localisation (Optionnel)") {
                    TextField("Latitude", text: $viewModel.latitudeString)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $viewModel.longitudeString)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
                        viewModel.save(to: modelContext)
                        dismiss()
                    }
                }
            }
        }
    }
}
