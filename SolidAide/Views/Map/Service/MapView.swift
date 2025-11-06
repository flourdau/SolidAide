import SwiftUI
import SwiftData
import MapKit

// ---------------------------------------------------------------
// Extension qui fournit une coordonnée « user » utilisable dans
// l’annotation Map. Elle doit être visible avant l’usage dans la vue.
// ---------------------------------------------------------------
extension CLLocationCoordinate2D {
    /// Position fictive de l’utilisateur (peut être adaptée dynamiquement)
    static let user = CLLocationCoordinate2D(latitude: 48.889655,
                                            longitude: 2.339581)
}

// =================================================================
// MapView – carte + liste des services
// =================================================================
struct MapView: View {
    // -----------------------------------------------------------------
    // 1️⃣  Adresse e‑mail stockée (définie dans SolidAideApp)
    // -----------------------------------------------------------------
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    // -----------------------------------------------------------------
    // 2️⃣  Données SwiftData
    // -----------------------------------------------------------------
    @Query private var usersFound: [UserClass]                 // Tous les comptes
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass] // Services triés
    @Query private var profiles: [ProfileClass]               // Tous les profils (annotations)

    // -----------------------------------------------------------------
    // 3️⃣  États UI
    // -----------------------------------------------------------------
    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var context

    @State private var showingAddService = false
    @State private var searchText = ""
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.889655,
                                          longitude: 2.339581),
            span:   MKCoordinateSpan(latitudeDelta: 0.08,
                                      longitudeDelta: 0.08)
        )
    )
    @State private var viewMode = 0                     // 0 = Carte, 1 = Liste
    @State private var selectedSkill: SkillsEnum? = nil // Filtre par compétence

    // -----------------------------------------------------------------
    // 4️⃣  Utilisateur courant (déduit de l’e‑mail stocké)
    // -----------------------------------------------------------------
    private var currentUser: UserClass? {
        usersFound.first { $0.logIn == loggedInEmail }
    }

    // -----------------------------------------------------------------
    // 5️⃣  Filtrage des services (skill + recherche texte)
    // -----------------------------------------------------------------
    private var filteredServices: [ServiceClass] {
        var result = services

        // Filtre par compétence sélectionnée
        if let skill = selectedSkill {
            result = result.filter { $0.skill == skill }
        }

        // Filtre texte libre
        guard !searchText.isEmpty else { return result }
        let lower = searchText.lowercased()
        return result.filter {
            $0.serviceDescription.lowercased().contains(lower) ||
            $0.city.lowercased().contains(lower) ||
            $0.profileId.pseudo.lowercased().contains(lower)
        }
    }

    // -----------------------------------------------------------------
    // 6️⃣  Corps de la vue
    // -----------------------------------------------------------------
    var body: some View {
        // Synchroniser la session globale dès que l’on connaît l’utilisateur
        let _ = DispatchQueue.main.async {
            if let u = currentUser, userSession.currentUser?.id != u.id {
                userSession.currentUser = u
            }
        }

        NavigationStack {
            ZStack(alignment: .bottom) {
                // ---------------------------------------------------------
                // 6.1️⃣  Mode Carte
                // ---------------------------------------------------------
                if viewMode == 0 {
                    Map(position: $cameraPosition) {
                        // ---- Annotations des profils ----
                        ForEach(profiles, id: \.self) { profile in
                            Annotation(
                                profile.pseudo,
                                coordinate: CLLocationCoordinate2D(
                                    latitude: profile.profilePosition?.latitude ?? 0,
                                    longitude: profile.profilePosition?.longitude ?? 0
                                ),
                                anchor: .center
                            ) {
                                ProfileAnnotationView(profile: profile)
                                    .frame(width: 200, height: 100)
                            }
                        }

                        // ---- Position de l'utilisateur (icône fixe) ----
                        Annotation("Vous êtes ici.", coordinate: .user, anchor: .bottom) {
                            Image(systemName: "figure.wave")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.mintGreen)
                        }
                        .annotationTitles(.visible)
                    }
                    .onAppear {
                        // Demander la permission de localisation dès l’ouverture
                        CLLocationManager().requestWhenInUseAuthorization()
                    }
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapPitchToggle()
                        MapScaleView()
                    }
                    .mapStyle(.standard(elevation: .realistic))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // ---------------------------------------------------------
                // 6.2️⃣  Mode Liste
                // ---------------------------------------------------------
                } else {
                    List {
                        ForEach(filteredServices) { service in
                            NavigationLink {
                                ServiceDetailView(service: service,
                                                  user: currentUser ?? usersFound.first!)
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: service.skill.icon)
                                        .foregroundColor(.blue)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(service.skill.rawValue)
                                            .font(.headline)

                                        Text(service.serviceDescription)
                                            .font(.subheadline)
                                            .lineLimit(1)

                                        Text("Demandé par : \(service.profileId.pseudo) • \(service.city)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteService)
                    }
                    .listStyle(.plain)
                    .padding(.top, 48)
                }

                // ---------------------------------------------------------
                // 6.3️⃣  Contrôles communs (picker + bouton d’ajout)
                // ---------------------------------------------------------
                VStack(spacing: 0) {
                    Picker("Vue", selection: $viewMode) {
                        Text("Carte").tag(0)
                        Text("Liste").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    Spacer()

                    ButtonAddServiceExtView(showingAddService: $showingAddService)
                }
                .navigationTitle("Bienvenue  \(userSession.currentUser?.profileId?.pseudo ?? "") ")
                .searchable(text: $searchText,
                            placement: .navigationBarDrawer,
                            prompt: "Rechercher un service")
            }   // └─ ZStack
            .sheet(isPresented: $showingAddService) {
                ServiceEditView(viewModel: ServiceFormViewModel(userSession: currentUser))
            }
        }   // └─ NavigationStack
    }

    // -----------------------------------------------------------------
    // 7️⃣  Suppression d’un service (appelée depuis la liste)
    // -----------------------------------------------------------------
    private func deleteService(at offsets: IndexSet) {
        for index in offsets {
            let service = services[index]
            context.delete(service)
        }
        try? context.save()
    }
}

// =================================================================
// PREVIEW – container complet (mémoire uniquement) pour éviter les
// erreurs “Missing model container for type …”
// =================================================================
//#Preview {
//    do {
//        // Configuration en mémoire uniquement (utile pour les previews)
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//
//        // Toutes les entités utilisées dans MapView doivent être présentes
//        let container = try ModelContainer(
//            for: [
//                UserClass.self,
//                ProfileClass.self,
//                ServiceClass.self,
//                ChatClass.self,
//                TimeBankClass.self
//            ],
//            configurations: config
//        )
//
//        // Peupler la base avec les données factices
//        GenerateDataBaseFunc(context: container.mainContext)
//
//        // Simuler un utilisateur déjà connecté
//        UserDefaults.standard.set("severine@email.fr", forKey: "loggedInEmail")
//
//        return MapView()
//            .modelContainer(container)
//            .environmentObject(UserSession())
//    } catch {
//        fatalError("Impossible de créer le ModelContainer de preview : \(error)")
//    }
//}
