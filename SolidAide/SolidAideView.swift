//
//  ContentView.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

struct SolidAideView: View {
    /*
     USER FICTIF
     */
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "florian@email.fr"
    }) var usersFound: [UserClass]

    @Environment(\.modelContext) private var context
    @State var userSession: UserSession
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        TabView() {
            MapView()
                .tabItem {
                    Text("Rechercher")
                    Image(systemName: "magnifyingglass")
                }
                .environment(userSession)
            
            DashboardView()
                .tabItem {
                    Text("Tableau de bord")
                    //                    Text(userLogged.profileId.pseudo)
                    Image(systemName: "square.grid.2x2.fill")
                }

            ProfileListView()
                .tabItem {
                    Text("Tableau de bord")
                    //                    Text(userLogged.profileId.pseudo)
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
    
    
    init() {
        _userSession = State(initialValue: UserSession())
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
