//
//  MapView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    @Environment(\.modelContext) private var context
    @Query var profiles: [ProfileClass]
    @State private var searchText = ""
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    let locationManager = CLLocationManager()
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Map(position: $cameraPosition) {
                    ForEach(profiles, id: \.self){ profile in
                        if let position = profile.userPosition {
                            Annotation(profile.pseudo, coordinate: profile.userPosition ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                                Image(systemName: "figure.wave")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.warmCoral)
                            }
                            
                            
                        }
                        UserAnnotation()
                    }
                    .tint(.warmCoral)
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
                }
                .navigationTitle("Bienvenue")
                .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Rechercher un service")
            }
        }
    }
    
    
    
    
    
}


#Preview {
    MapView()
        .modelContainer(for: [
            UserClass.self,
            ProfileClass.self,
            ChatClass.self,
            ServiceClass.self,
            TimeBankClass.self
        ])
}
