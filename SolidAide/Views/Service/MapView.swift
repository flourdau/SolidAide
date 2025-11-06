//
//  MapView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    @Environment(\.modelContext) private var context
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    @Query var profiles: [ProfileClass]
    @State var userSession: UserSession
    @State var showingAddService = false
    @State private var searchText = ""
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.889655, longitude: 2.339581), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)))
    let locationManager = CLLocationManager()
    @State var isToggle: Bool = false
    private var isShowingMap: Bool { viewMode == 0 }
    @State private var viewMode: Int = 0
    @State private var selectedSkill: SkillsEnum? = nil // Le filtre de compétence actif
    var filteredProfiles: [ProfileClass] {
        var filtered = profiles
        if let skill = selectedSkill {
            filtered = filtered.filter { profile in
                if let profileSkills = profile.skills {
                    return profileSkills.contains(skill)
                } else {
                    return false
                }
            }
        }
        
        guard !searchText.isEmpty else {
            return filtered
        }
        
        let searchLowercased = searchText.localizedLowercase
        
        return filtered.filter { profile in
            profile.pseudo.localizedLowercase.contains(searchLowercased) ||
            profile.city?.localizedLowercase.contains(searchLowercased) == true
        }
    }
    
    var servicesForFilteredProfiles: [ServiceClass] {
        let matchingProfileIDs = Set(filteredProfiles.map { $0.id })
        
        var servicesFromMatchingProfiles = services.filter { service in
            matchingProfileIDs.contains(service.profileId.id)
        }
        
        if let skill = selectedSkill {
            servicesFromMatchingProfiles = servicesFromMatchingProfiles.filter { $0.skill == skill }
        } else if !searchText.isEmpty {
            let searchLowercased = searchText.localizedLowercase
            
            servicesFromMatchingProfiles = servicesFromMatchingProfiles.filter { service in
                service.serviceDescription.localizedLowercase.contains(searchLowercased) ||
                service.city.localizedLowercase.contains(searchLowercased) ||
                service.profileId.pseudo.localizedLowercase.contains(searchLowercased)
            }
        }
        
        return servicesFromMatchingProfiles
    }
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        
        NavigationStack {
            ZStack(alignment: .bottom){
                if isShowingMap {
                    Map(position: $cameraPosition) {
                        ForEach(filteredProfiles, id: \.self) { profile in
                            if let coordinate = profile.profilePosition {
                                Annotation(profile.pseudo, coordinate: coordinate, anchor: .center) {
                                    ProfileAnnotationView(profile: profile)
                                        .frame(width: 200, height: 100)
                                }
                            }
                        }
                        
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    List {
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
                        }
                    }
                    .padding(.top, 48)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
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
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }
            
            .navigationTitle("Bienvenue \(userSession.currentUser?.profileId?.pseudo ?? "") ")
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Rechercher un service ou une catégorie") {
                
                Section("Filtrer par catégorie") {
                    
                    Button {
                        selectedSkill = nil
                        searchText = ""
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.gray)
                            Text("Toutes les catégories")
                        }
                    }
                    
                    ForEach(SkillsEnum.allCases, id: \.self) { skill in
                        Button {
                            selectedSkill = skill
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
                if newValue.isEmpty {
                    selectedSkill = nil
                }
            }
            .sheet(isPresented: $showingAddService) {
                ServiceEditView(viewModel: ServiceFormViewModel(userSession: usersFound.first!))
            }
            
        }
    }
    
    /// Action (D)ELETE
    private func deleteService(at offsets: IndexSet) {
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

#Preview {
    
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
