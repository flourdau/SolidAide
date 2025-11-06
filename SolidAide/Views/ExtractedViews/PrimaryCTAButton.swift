//
//  PrimaryCTAButton.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI

struct PrimaryCTAButton: View {
    let title: String
    let icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 18)
            .background(
                Capsule().fill(Color(.systemBlue))
                    .shadow(color: .black.opacity(0.2), radius: 6, y: 4)
            )
            .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    PrimaryCTAButton(
        title: "Demande d’aide",
        icon: "hand.raised.fill",
        action: { print("Bouton appuyé") }
    )
    .padding()
//    .previewLayout(.sizeThatFits)
}
