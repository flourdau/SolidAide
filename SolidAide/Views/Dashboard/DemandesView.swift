//
//  DemandesView.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI
import SwiftData

struct DemandesView: View {
    @Environment(\.modelContext) private var context
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    })
    var usersFound: [UserClass]
    @State var userSession: UserSession
    @State var showingAlert = false
    @State var showingAddService = false
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    @Query var profiles: [ProfileClass]
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        List {
            ForEach(services) { service in
                if service.profileId.userId == usersFound[0] {
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
            .onDelete(perform: deleteService)
        }
        .navigationTitle("Mes demandes")
        ButtonAddServiceExtView(showingAddService: $showingAddService)
            .padding(.bottom, 20)

    }
    
    /// Action (D)ELETE
    private func deleteService(at offsets: IndexSet) {
        for index in offsets {
            let serviceToDelete = services[index]
            context.delete(serviceToDelete)
            
        }
    }
    
    init() {
        _userSession = State(initialValue: UserSession())
    }
}

#Preview {
    DemandesView()
}
