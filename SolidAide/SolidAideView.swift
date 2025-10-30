//
//  ContentView.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

struct SolidAideView: View {
    var body: some View {
        TabView() {
            MapView()
                .tabItem {
                    Text("Rechercher")
                    Image(systemName: "magnifyingglass")
                }
            
            DashboardView()
                .tabItem {
                    Text("Tableau de bord")
                    Image(systemName: "square.grid.2x2.fill")
                }
            
            ChatView()
                .tabItem {
                    Text("Messagerie")
                    Image(systemName: "bubble")
                }
            
            AdminDataBaseView()
                .tabItem {
                    Text("Messagerie")
                    Image(systemName: "arrow.2.circlepath.circle")
                }
            
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self, configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        return SolidAideView()
            .modelContainer(container)
        
    } catch {
       fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}
