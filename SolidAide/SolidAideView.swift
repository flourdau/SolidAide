//
//  ContentView.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

struct SolidAideView: View {
    @Environment(\.modelContext) private var context
    @Query var users: [UserClass]
    var userLogged: UserClass {
        users[12]
    }

    var body: some View {
        TabView() {
            MapView()
                .tabItem {
                    Text("Rechercher")
                    Image(systemName: "magnifyingglass")
                }
            
            DashboardView()
                .tabItem {
                    Text(userLogged.profileId?.pseudo ?? "Tableau de bord")
                    Image(systemName: "square.grid.2x2.fill")
                }
            
            ChatView()
                .tabItem {
                    Text("Messagerie")
                    Image(systemName: "bubble")
                }
            
            //  ACommenter
            AdminDataBaseView()
                .tabItem {
                    Text("Admin")
                    Image(systemName: "arrow.2.circlepath.circle")
                }
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self,
                                           ProfileClass.self,
                                           ServiceClass.self,
                                           ChatClass.self,
                                           TimeBankClass.self,
                                           configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        
        return SolidAideView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
        
    }
    
}
