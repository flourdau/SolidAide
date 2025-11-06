//
//  ProfileDetailView.swift
//  SolidAide
//
//  Created by apprenant78 on 04/11/2025.
//

// ProfileDetailView.swift
import SwiftUI

struct ProfileDetailView: View {
    let profile: ProfileClass
    
    @State private var showingEditSheet = false
    
    var body: some View {
        ProfileCardView(profile: profile)
        
        Form {
            Section("Informations") {
                LabeledContent("Ville", value: profile.city ?? "N/A")
                
                if let aboutMe = profile.aboutMe, !aboutMe.isEmpty {
                    Text(aboutMe)
                }
            }
            
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
            AddEditProfileView(profile: profile)
        }
    }
}
