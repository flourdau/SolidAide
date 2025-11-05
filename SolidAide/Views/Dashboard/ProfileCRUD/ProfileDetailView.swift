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
        VStack(spacing: 0) {
            ProfileCardView(profile: profile)
            
            
            Form {
                Section("Informations") {
//                    Text(profile.pseudo).font(.title2)
                    LabeledContent("Ville", value: profile.city ?? "N/A")
                    
                    if let birthday = profile.birthday {
                        LabeledContent("Anniversaire", value: birthday, format: .dateTime.day().month().year())
                    }
                    
                    if let aboutMe = profile.aboutMe, !aboutMe.isEmpty {
                        Text(aboutMe)
                    }
                }
                
                //            Section("Localisation") {
                ////                if let pos = profile.profilePosition {
                ////                    LabeledContent("Latitude", value: String(pos.latitude))
                ////                    LabeledContent("Longitude", value: String(pos.longitude))
                ////                } else {
                ////                    Text("Localisation non définie.")
                ////                }
                //            }
                
                // On pourrait ajouter d'autres sections pour les listes (skills, contacts, etc.)
            }
            .scrollDisabled(true)
            SkillButtonsView()
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


// MARK: – Mock model for preview
extension ProfileClass {
    /// Quick mock data used only for SwiftUI previews.
    static var mock: ProfileClass {
        // Replace these arguments with whatever your real initializer requires.
        ProfileClass(
            pseudo: "Jean Dupont",
            city: "Paris",
            birthday: Date(timeIntervalSince1970: 631152000), // 1990‑01‑01
            aboutMe: "Développeur passionné par SwiftUI et l’IA.",
            profilePosition: nil   // ou ProfilePosition(latitude: 48.8566, longitude: 2.3522)
        )
    }
}

// MARK: – Classic preview provider (works on all supported Xcode versions)
struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {               // Needed because you use `.navigationTitle`
            ProfileDetailView(profile: .mock)
        }
        .previewDevice("iPhone 15")
    }
}

/*
 // If you’re on Xcode 15.3+ you can also use the newer #Preview macro:
 #Preview {
     NavigationStack {
         ProfileDetailView(profile: .mock)
     }
 }
 */

