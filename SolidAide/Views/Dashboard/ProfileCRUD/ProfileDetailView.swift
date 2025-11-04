//
//  ProfileDetailView.swift
//  SolidAide
//
//  Created by apprenant78 on 04/11/2025.
//

// ProfileDetailView.swift
import SwiftUI

struct ProfileDetailView: View {
    // Le profil à afficher (reçu de la liste)
    let profile: ProfileClass
    
    // État pour afficher la feuille de modification
    @State private var showingEditSheet = false
    
    var body: some View {
        Form {
            Section("Informations") {
                Text(profile.pseudo).font(.title)
                LabeledContent("Ville", value: profile.city ?? "N/A")
                
                if let birthday = profile.birthday {
                    LabeledContent("Anniversaire", value: birthday, format: .dateTime.day().month().year())
                }
                
                if let aboutMe = profile.aboutMe, !aboutMe.isEmpty {
                    Text(aboutMe)
                }
            }
            
            Section("Localisation") {
//                if let pos = profile.profilePosition {
//                    LabeledContent("Latitude", value: String(pos.latitude))
//                    LabeledContent("Longitude", value: String(pos.longitude))
//                } else {
//                    Text("Localisation non définie.")
//                }
            }
            
            // On pourrait ajouter d'autres sections pour les listes (skills, contacts, etc.)
        }
        .navigationTitle(profile.pseudo)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Modifier") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            // Ouvre le formulaire en mode "modification"
            // en lui passant le profil existant
            AddEditProfileView(profile: profile)
        }
    }
}

//#Preview {
//    ProfileDetailView(profile: <#ProfileClass#>)
//}
