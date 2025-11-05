//
//  ProfileAnnotationView.swift
//  SolidAide
//
//  Created by apprenant78 on 05/11/2025.
//

import SwiftUI


struct ProfileAnnotationView: View {
    
    let profile: ProfileClass
    @State private var offset: CGSize = .zero

    @State private var isToggled = false
    
    var body: some View {

        Button {
            isToggled.toggle()
        } label: {

            VStack(alignment: .center) {
                if isToggled {
                    Text(profile.serviceId?.first?.serviceDescription ?? "Info")
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.white)
                        .background(        Color(.mintGreen.opacity(0.95)),
                            in: UnevenRoundedRectangle(
                                topLeadingRadius: 16, bottomLeadingRadius:  16, bottomTrailingRadius: 0,
                                topTrailingRadius: 16
                            )
                        )
//                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
                
                Image(systemName: "figure.wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.warmCoral)

            }
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
//            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity)

    }
}

