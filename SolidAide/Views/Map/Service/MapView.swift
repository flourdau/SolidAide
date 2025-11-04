//
//  MapView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData
import MapKit
// FILTRER SURR LA DISTANCE en liste...

struct MapView: View {
    /*
     USER FICTIF
     */
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    @State var userSession: UserSession
    
    @Environment(\.modelContext) private var context
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    //@Query private var services: [ServiceClass]
    @Query var profiles: [ProfileClass]
    @State var showingAddService = false
    @State private var searchText = ""
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.889655, longitude: 2.339581), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)))
    //@State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
       let locationManager = CLLocationManager()
    
    private var isShowingMap: Bool {
        viewMode == 0
    }
    @State private var viewMode: Int = 0
    @State private var selectedSkill: SkillsEnum? = nil
    var filteredServices: [ServiceClass] {
        var filtered = services
        
        // A. Filtrer par Compétence (SkillsEnum)
        if let skill = selectedSkill {
            filtered = filtered.filter { $0.skill == skill }
        }
        
        // B. Filtrer par Texte de Recherche (sur plusieurs champs)
        guard !searchText.isEmpty else {
            return filtered
        }
        
        let searchLowercased = searchText.localizedLowercase
        
        return filtered.filter { service in
            return service.serviceDescription.localizedLowercase.contains(searchLowercased) ||
            service.city.localizedLowercase.contains(searchLowercased) ||
            service.profileId.pseudo.localizedLowercase.contains(searchLowercased)
        }
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
                        ForEach(profiles, id: \.self){ profile in
                            Annotation(profile.pseudo, coordinate:  CLLocationCoordinate2D(latitude: profile.profilePosition?.latitude ?? 0,longitude: profile.profilePosition?.longitude ?? 0), anchor: .center) {
                                Image(systemName: "figure.wave")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.warmCoral)
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
                                .foregroundStyle(Color.mintGreen)
                        }
                        .annotationTitles(.visible)
                        //UserAnnotation()
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
                    //.ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        
                        ForEach(services) { service in
                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                HStack {
                                    Image(systemName: service.skill.icon)
                                        .foregroundColor(.blue)
                                    
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
                        .onDelete(perform: deleteService) // (D)ELETE
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                VStack(spacing: 0) {
                    
                    Picker("Vue", selection: $viewMode) {
                        Text("Carte").tag(0)
                        Text("Liste").tag(1)
                    }
                    
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    Spacer()
                }
                .navigationTitle("Bienvenue  \(userSession.currentUser?.profileId?.pseudo ?? "") ")
                .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Rechercher un service")
                NavigationLink {
                    ServiceEditView(viewModel: ServiceFormViewModel())
                } label: {
                    HStack{
                        Image(systemName:"hand.raised.fill")
                        VStack{
                            Text("Demander")
                            Text("de l'aide")
                        }
                    }
                    .padding(12)
                    //.padding(.trailing, 8)
                    .background(.deepBlue)
                    .foregroundStyle(.white)
                    .cornerRadius(32)
                    .font(.system(size: 20))
                    .bold()
                    
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                }
                
            }
            
            
        }
    }
    
    /// Action (D)ELETE
    private func deleteService(at offsets: IndexSet) {
        for index in offsets {
            let service = services[index]
            context.delete(service)
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
