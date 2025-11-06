//
//  ServiceListView.swift
//  SolidAide
//
//  Created by Apprenant 78 on 05/11/2025.
//


import SwiftUI
import SwiftData

struct ServiceListView: View {
    // -----------------------------------------------------------------
    // 1️⃣  Données SwiftData (identiques à celles du MapView)
    // -----------------------------------------------------------------
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    @Query private var usersFound: [UserClass]

    // -----------------------------------------------------------------
    // 2️⃣  Utilisateur connecté (fallback sur l’e‑mail stocké)
    // -----------------------------------------------------------------
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    private var currentUser: UserClass? {
        usersFound.first { $0.logIn == loggedInEmail }
    }

    // -----------------------------------------------------------------
    // 3️⃣  Corps de la vue – même UI que le mode « Liste » du MapView
    // -----------------------------------------------------------------
    var body: some View {
        List {
            ForEach(services) { service in
                NavigationLink {
                    ServiceDetailView(service: service,
                                      user: currentUser ?? usersFound.first!)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: service.skill.icon)
                            .foregroundColor(.blue)

                        VStack(alignment: .leading) {
                            Text(service.skill.rawValue)
                                .font(.headline)

                            Text(service.serviceDescription)
                                .font(.subheadline)
                                .lineLimit(1)

                            Text("Demandé par : \(service.profileId.pseudo) | \(service.city)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteService)
        }
        .navigationTitle("Demandes de service")
        .navigationBarTitleDisplayMode(.inline)
    }

    // -----------------------------------------------------------------
    // 4️⃣  Suppression d’un service (identique à MapView)
    // -----------------------------------------------------------------
    @Environment(\.modelContext) private var context

    private func deleteService(at offsets: IndexSet) {
        for index in offsets {
            let service = services[index]
            context.delete(service)
        }
        try? context.save()
    }
}