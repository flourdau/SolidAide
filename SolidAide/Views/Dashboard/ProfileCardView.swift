//
//  ProfileCardView.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI

struct ProfileCardView: View {
    let profile: ProfileClass
    var body: some View {
        HStack(spacing: 14) {
            ProfileAvatar(imageData: profile.imageData, size: 60)

            VStack(alignment: .leading, spacing: 2) {
                Text("Carte de visite")
                    .font(.headline)
                Text(profile.pseudo)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(.separator), lineWidth: 0.4))
    }
}
