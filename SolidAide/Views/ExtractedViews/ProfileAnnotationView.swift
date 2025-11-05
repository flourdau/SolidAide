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



// MARK: – Mock model for preview
extension ProfileAnnotationView {
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
struct ProfileAnnotationView_Previews: PreviewProvider {
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
