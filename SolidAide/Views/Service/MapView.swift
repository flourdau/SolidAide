//
//  MapView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData
import MapKit

// NOTE: Assurez-vous que SkillsEnum est défini et qu'il inclut String, CaseIterable, Codable
// Ex: enum SkillsEnum: String, CaseIterable, Codable { ... }

struct MapView: View {
    
    // --- Requêtes SwiftData ---
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    
    @Environment(\.modelContext) private var context
    
    // Services et Profiles (Sources de données complètes)
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    @Query var profiles: [ProfileClass]
    
    // --- États de la Vue ---
    @State var userSession: UserSession
    @State var showingAddService = false
    @State private var searchText = "" // Texte entré par l'utilisateur (pour le filtrage)
    
    // Position initiale: Revenu à la version `userLocation` pour le bouton natif
    //@State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    // Ancienne valeur (maintenue si vous préférez un point fixe) :
     @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.889655, longitude: 2.339581), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)))
    
    let locationManager = CLLocationManager()
    @State var isToggle: Bool = false
    
    private var isShowingMap: Bool { viewMode == 0 }
    @State private var viewMode: Int = 0
    @State private var selectedSkill: SkillsEnum? = nil // Le filtre de compétence actif
    
    // --- LOGIQUE DE FILTRAGE PRINCIPALE : PROFILES ---
    // Les profils sont filtrés par compétence ET par recherche textuelle (pseudo/ville)
    var filteredProfiles: [ProfileClass] {
        var filtered = profiles
        
        // 1. Filtrer par Compétence (SkillsEnum)
        if let skill = selectedSkill {
            // Un profil correspond s'il a la compétence dans sa propriété 'skills'
            filtered = filtered.filter { profile in
                if let profileSkills = profile.skills {
                    return profileSkills.contains(skill)
                } else {
                    return false
                }
            }
        }
        
        // 2. Filtrer par Texte de Recherche (sur le pseudo et la ville du profil)
        guard !searchText.isEmpty else {
            return filtered
        }
        
        let searchLowercased = searchText.localizedLowercase
        
        return filtered.filter { profile in
            // Recherche dans le pseudo OU la ville du profil
            profile.pseudo.localizedLowercase.contains(searchLowercased) ||
            profile.city?.localizedLowercase.contains(searchLowercased) == true
        }
    }
    
    // --- LOGIQUE POUR LA LISTE : SERVICES ---
    // Affiche les services qui correspondent aux profils filtrés
    var servicesForFilteredProfiles: [ServiceClass] {
        
        // Obtenir les ID des profils filtrés
        let matchingProfileIDs = Set(filteredProfiles.map { $0.id })
        
        // 1. Filtrer les services pour ne garder que ceux créés par ces profils
        var servicesFromMatchingProfiles = services.filter { service in
            matchingProfileIDs.contains(service.profileId.id)
        }
        
        // 2. Si un filtre de compétence est actif, on n'affiche que les services de cette compétence
        if let skill = selectedSkill {
            // On utilise le filtre sur les services car c'est plus direct pour la liste
            servicesFromMatchingProfiles = servicesFromMatchingProfiles.filter { $0.skill == skill }
        } else if !searchText.isEmpty {
            // Si seul le texte est utilisé (pas de filtre de compétence), on filtre aussi par le texte sur les champs du service
            let searchLowercased = searchText.localizedLowercase
            
            servicesFromMatchingProfiles = servicesFromMatchingProfiles.filter { service in
                service.serviceDescription.localizedLowercase.contains(searchLowercased) ||
                service.city.localizedLowercase.contains(searchLowercased) ||
                service.profileId.pseudo.localizedLowercase.contains(searchLowercased)
            }
        }
        
        return servicesFromMatchingProfiles
    }
    
    // --- VUE PRINCIPALE ---
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        
        NavigationStack {
            
            ZStack(alignment: .bottom){
                
                // --- 1. COUCHE DE FOND : CARTE OU LISTE ---
                if isShowingMap {
                    
                    Map(position: $cameraPosition) {
                        // Afficher les annotations UNIQUEMENT pour les profils filtrés
                        ForEach(filteredProfiles, id: \.self){ profile in
                            if let coordinate = profile.profilePosition {
                                Annotation(profile.pseudo, coordinate: coordinate, anchor: .center) {
                                    ProfileAnnotationView(profile: profile)
                                        .frame(width: 200, height: 100)
                                }
                            }
                        }
                        // Annotation utilisateur manuelle (gardée pour votre position .user fictive)
                        Annotation(
                            "Vous êtes ici.",
                            coordinate: .user,
                            anchor: .bottom
                        ) {
                            Image(systemName: "figure.wave")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color("mintGreen")) // Utilisation de votre couleur
                        }
                        .annotationTitles(.visible)
                        
                    }
                    .onAppear {
                        locationManager.requestWhenInUseAuthorization()
                    }
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapPitchToggle()
                        MapScaleView()
                    }
                    .mapStyle(.standard(elevation: .realistic))
                    // .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    // LISTE : Utilise le tableau des SERVICES FILTRÉS
                    List {
                        // Message si aucun résultat trouvé
                        if servicesForFilteredProfiles.isEmpty && (!searchText.isEmpty || selectedSkill != nil) {
                            ContentUnavailableView{
                                Label("Aucun service trouvé", systemImage: "exclamationmark.circle")
                            }
                           
                        } else {
                            ForEach(servicesForFilteredProfiles) { service in // ✅ Utilise filteredServices
                                NavigationLink(destination: ServiceDetailView(service: service, user: usersFound.first!)) {
                                    HStack {
                                        Image(systemName: service.skill.icon)
                                            .foregroundColor(.warmCoral)
                                        
                                        VStack(alignment: .leading) {
                                            Text(service.skill.rawValue).font(.headline)
                                            
                                            Text(service.serviceDescription)
                                                .font(.subheadline)
                                                .lineLimit(1)
                                            
                                            Text("Demandé par: \(service.profileId.pseudo) | \(service.city)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
//                            .onDelete(perform: deleteService)
                        }
                    }
                    .padding(.top, 48) // Gardé votre padding
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                // --- 2. COUCHE DE CONTRÔLE (Picker) ---
                VStack(spacing: 0) {
                    Picker("Vue", selection: $viewMode) {
                        Text("Carte").tag(0)
                        Text("Liste").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                 
                    ButtonAddServiceExtView(showingAddService: $showingAddService)
                        .padding(.bottom, 20) // Ajout d'un padding pour flotter au dessus du bord
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            } // Fin ZStack
            
            .navigationTitle("Bienvenue \(userSession.currentUser?.profileId?.pseudo ?? "") ")
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Rechercher un service ou une catégorie") {
                
                Section("Filtrer par catégorie") {
                    
                    // Bouton pour réinitialiser le filtre
                    Button {
                        selectedSkill = nil
                        searchText = ""
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.gray)
                            Text("Toutes les catégories")
                        }
                    }
                    
                    // Liste des catégories
                    ForEach(SkillsEnum.allCases, id: \.self) { skill in
                        // Action: Quand on tape sur une catégorie, on définit selectedSkill
                        Button {
                            selectedSkill = skill
                            // Afficher la catégorie dans la barre de recherche
                            searchText = skill.rawValue
                        } label: {
                            HStack {
                                Image(systemName: skill.icon)
                                Text(skill.rawValue)
                            }
                        }
                    }
                }
            }
            .onChange(of: searchText) { oldValue, newValue in
                // Réinitialiser le filtre de compétence si l'utilisateur efface le texte de recherche
                if newValue.isEmpty {
                    selectedSkill = nil
                }
            }
            .sheet(isPresented: $showingAddService) {
                ServiceEditView(viewModel: ServiceFormViewModel(userSession: usersFound.first!))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // Reste vide
                }
            }
            
        } // Fin NavigationStack
    }
    
    /// Action (D)ELETE
    private func deleteService(at offsets: IndexSet) {
        // Utiliser l'index dans le tableau filtré pour trouver le bon objet à supprimer
        for index in offsets {
            let serviceToDelete = servicesForFilteredProfiles[index]
            context.delete(serviceToDelete)
        }
    }
    
    init() {
        _userSession = State(initialValue: UserSession())
    }
}

extension CLLocationCoordinate2D {
    static let user = CLLocationCoordinate2D(
        latitude: 48.889655, longitude: 2.339581
    )
}

// NOTE: Le code de la #Preview n'est pas modifié car il est dans un bloc do-catch






#Preview {
    ////    MapView()
    ////        .modelContainer(for: [
    ////            UserClass.self,
    ////            ProfileClass.self,
    ////            ChatClass.self,
    ////            ServiceClass.self,
    ////            TimeBankClass.self
    ////        ])
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self, ServiceClass.self, configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        
        return MapView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
        
    }
    
}
