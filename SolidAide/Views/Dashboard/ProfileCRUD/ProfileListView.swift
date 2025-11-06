//
//  ProfileListView.swift
//  SolidAide
//
//  Created by apprenant78 on 04/11/2025.
//


// ProfileListView.swift
import SwiftUI
import SwiftData

struct ProfileListView: View {
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
                            Text(profile.city ?? "Ville non définie").font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteProfiles)
            }
            .navigationTitle("Profils")
            .navigationDestination(for: ProfileClass.self) { profile in
                // Destination pour la vue de détail
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
    let container = try! ModelContainer(for: ProfileClass.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    return ProfileListView().modelContainer(container)
}
#Preview {
    ProfileListView()
}
