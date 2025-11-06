//
//  ProfileAvatar.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI

struct ProfileAvatar: View {
    var size: CGFloat = 72
    var ringColor: Color = .blue
    var ringWidth: CGFloat = 3
    
    var body: some View {
        Group {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(ringColor.opacity(0.85))
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(ringColor, lineWidth: ringWidth))
        .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
    }
}
