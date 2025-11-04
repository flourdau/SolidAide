//
//  ContentView.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData
public let kShowAdminTabKey = "showAdminTab"
struct SolidAideView: View {
    @AppStorage(kShowAdminTabKey) private var showAdminTab: Bool = false

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Text("Rechercher")
                    Image(systemName: "magnifyingglass")
                }

            TimeBankView()
                .tabItem {
                    Text("Tableau de bord")
                    Image(systemName: "square.grid.2x2.fill")
                }

            ChatView()
                .tabItem {
                    Text("Messagerie")
                    Image(systemName: "bubble")
                }

            // L’onglet n’est ajouté que si `showAdminTab` vaut true
            if showAdminTab {
                AdminDataBaseView()
                    .tabItem {
                        Text("Admin")
                        Image(systemName: "arrow.2.circlepath.circle")
                    }
            }
        }
    }
}

#Preview {
    SolidAideView()
        .modelContainer(for: [
            UserClass.self,
            ProfileClass.self,
            ChatClass.self,
            ServiceClass.self,
            TimeBankClass.self
        ])
}

