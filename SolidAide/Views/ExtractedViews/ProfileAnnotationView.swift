import SwiftUI
import SwiftData

// ---------------------------------------------------------------
//  ProfileAnnotationView – affichage d’une annotation sur la carte
// ---------------------------------------------------------------
struct ProfileAnnotationView: View {
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
//    @State var userSession: UserSession
    
    
    
    let profile: ProfileClass                     // le profil affiché sur la carte
    @State private var offset: CGSize = .zero     // déplacement tactile (drag)
    @State private var isToggled = false         // indique si la petite bulle est ouverte
    
    // On a besoin de la session pour récupérer l’utilisateur connecté
    //    @EnvironmentObject private var userSession: UserSession
    
    var body: some View {
//        let _ = DispatchQueue.main.async {
//            if usersFound.first !== userSession.currentUser {
//                userSession.currentUser = usersFound.first
//            }
//        }
        // Le bouton entier (icône + bulle) sert de déclencheur
        Button {
            // Ouvre / ferme la petite bulle
            isToggled.toggle()
        } label: {
            VStack(alignment: .center) {
                // -------------------------------------------------
                // 1️⃣  Bulle verte (affichée quand isToggled == true)
                // -------------------------------------------------
                if isToggled {
                    // Le service lié à ce profil (le premier s’il y en a plusieurs)
                    if let service = profile.serviceId?.first {
                        // Navigation directe vers le détail du service
                        NavigationLink(
                            destination: ServiceDetailView(
                                service: service,
                                // Si la session n’est pas encore remplie, on crée un dummy user
//                                user: userSession.currentUser ?? UserClass(logIn: "", password: "", balance: 0)

                                user: usersFound[0]
                            )
                        ) {
                            // Le texte de la bulle conserve le même style que précédemment
                            Text(service.serviceDescription)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(
                                    Color(.mintGreen.opacity(0.95)),
                                    in: UnevenRoundedRectangle(
                                        topLeadingRadius: 16,
                                        bottomLeadingRadius: 16,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 16)
                                )
                        }
                        // On enlève le soulignement du lien pour qu’il ressemble à du texte normal
                        .buttonStyle(.plain)
                    } else {
                        // Aucun service associé → on garde le texte « Info » par défaut
                        Text("Info")
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(
                                Color(.mintGreen.opacity(0.95)),
                                in: UnevenRoundedRectangle(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 16)
                            )
                    }
                }
                
                // -------------------------------------------------
                // 2️⃣  Icône représentant le profil (figure.wave corail)
                // -------------------------------------------------
                Image(systemName: "figure.wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.warmCoral)
            }
            // -------------------------------------------------
            // 3️⃣  Gestes de déplacement (drag) – conservé tel quel
            // -------------------------------------------------
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in offset = value.translation }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
        }
        // Le bouton occupe toute la largeur disponible dans l’annotation
        .frame(maxWidth: .infinity)
    }
    
//    init() {
//        _userSession = State(initialValue: UserSession())
//    }
    
}
