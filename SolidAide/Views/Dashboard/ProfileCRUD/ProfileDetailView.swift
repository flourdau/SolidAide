import SwiftUI

struct ProfileDetailView: View {
    let profile: ProfileClass
    @State private var showingEditSheet = false

    private var selectedSkillSet: Set<SkillsEnum> {
        Set(profile.skills ?? [])
    }

    var body: some View {
        VStack(spacing: 0) {
            ProfileCardView(profile: profile)

            Form {
                Section("Informations") {
                    LabeledContent("Ville", value: profile.city ?? "N/A")
                    if let birthday = profile.birthday {
                        LabeledContent("Anniversaire", value: birthday, format: .dateTime.day().month().year())
                    }
                    if let about = profile.aboutMe, !about.isEmpty {
                        Text(about)
                    }
                }

                if !selectedSkillSet.isEmpty {
                    Section("Compétences") {
                        SkillSelector(selected: .constant(selectedSkillSet), editable: false, showOnlySelected: true)
                            .frame(height: 120)
                    }
                }
            }
        }
        .navigationTitle(profile.pseudo)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Modifier") { showingEditSheet = true }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            AddEditProfileView(profile: profile)
        }
    }
}
