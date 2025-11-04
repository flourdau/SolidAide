//
//  ProfilDetailView.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI
import SwiftData

struct ProfileDetailView: View {
    @Bindable var profile: ProfileClass

    var body: some View {
        VStack(spacing: 16) {
            Text(profile.pseudo)
                .font(.title2.weight(.semibold))
            Text(profile.aboutMe)
                .foregroundStyle(.secondary)
            Text(profile.city)
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        .padding()
        .navigationTitle("Profil de \(profile.pseudo)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let demoProfile = ProfileClass(
        pseudo: "Mélanie Blanc",
        city: "Paris",
        birthday: Date(timeIntervalSince1970: 946684800),
        aboutMe: "Passionnée de jardinage, j’aime aider et rencontrer de nouvelles personnes."
    )

    ProfileDetailView(profile: demoProfile)
}
