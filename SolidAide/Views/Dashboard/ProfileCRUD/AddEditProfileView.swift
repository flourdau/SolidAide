import SwiftUI
import SwiftData

struct AddEditProfileView: View {
    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: ProfileViewModel
    private var navigationTitle: String

    // MARK: - Initialiser pour la création
    init() {
        _viewModel = State(initialValue: ProfileViewModel())
        navigationTitle = "Nouveau Profil"
    }

    // MARK: - Initialiser pour la modification
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

                Section("Localisation (Optionnel)") {
                    TextField("Latitude", text: $viewModel.latitudeString)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $viewModel.longitudeString)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
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
        .environmentObject(UserSession())
        .modelContainer(
            try! ModelContainer(
                for: ProfileClass.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        )
}
