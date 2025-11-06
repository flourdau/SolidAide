import SwiftUI
import SwiftData

struct ProfileListView: View {
    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \ProfileClass.pseudo) private var profiles: [ProfileClass]

    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(profiles) { profile in
                    NavigationLink(value: profile) {
                        VStack(alignment: .leading) {
                            Text(profile.pseudo).font(.headline)
                            Text(profile.city ?? "Ville non définie")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteProfiles)
            }
            .navigationTitle("Profils")
            .navigationDestination(for: ProfileClass.self) { profile in
                ProfileDetailView(profile: profile)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditProfileView()
            }
        }
    }

    private func deleteProfiles(at offsets: IndexSet) {
        for index in offsets {
            let profile = profiles[index]
            modelContext.delete(profile)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ProfileClass.self, configurations: config)
        return ProfileListView()
            .modelContainer(container)
            .environmentObject(UserSession())
    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}
