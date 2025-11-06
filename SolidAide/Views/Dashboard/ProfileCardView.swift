//
//  ProfileCardView.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI

struct ProfileCardView: View {
    @EnvironmentObject private var userSession: UserSession
    let profile: ProfileClass
    var size: CGFloat = 72
    var ringColor: Color = .deepBlue
    var ringWidth: CGFloat = 3
    
    var body: some View {
        
        
        
        HStack(spacing: 14) {
            Group {
                //            if let data = imageData, let ui = UIImage(data: data) {
                //                Image(uiImage: ui)
                //                    .resizable()
                //                    .scaledToFill()
                //            }
                //            else {
                //            ProfileAvatar()
                Image(profile.imageURL ?? "")
                //                    .foregroundStyle(.tertiary)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(ringColor.opacity(0.85))
                //            }
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(ringColor, lineWidth: ringWidth))
            .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
            
            
            
            
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







