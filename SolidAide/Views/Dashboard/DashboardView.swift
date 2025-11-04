//
//  DashboardView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    /*
     USER FICTIF
     */
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    @State var userSession: UserSession
    
    
    @Environment(\.modelContext) private var context
    //    @Environment(CurrentProfileModel.self) private var profileModel
    @Query(sort: \ProfileClass.pseudo) private var profiles: [ProfileClass]
    // let profileInfo: ProfileClass
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        NavigationStack {
            HStack(alignment: .top, spacing: 20) {
                ZStack {
                    Circle()
                        .frame(width: 130, height: 130)
                        .foregroundStyle(.deepBlue)
                    Image(usersFound[0].profileId?.imageURL ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Carte de Visite")
                    Text(String("\(usersFound[0].profileId?.pseudo ?? "")"))
                }
            }
            .background(.thinMaterial)
                NavigationLink {
                    TimeBankView()
                } label: {
                    DashboardRow(
                        icon: "clock.badge.checkmark",
                        title: "Banque de temps",
                        trailing: Text(String("\(usersFound[0].balance)")).foregroundStyle(.green)
                    )
                }
                
                NavigationLink { ServicesOffertsView() } label: {
                    DashboardRow(icon: "hand.raised", title: "Services proposés")
                }
                
                NavigationLink { DemandesView() } label: {
                    DashboardRow(icon: "hand.wave", title: "Demandes de service")
                }
                
                NavigationLink { NotificationsView() } label: {
                    DashboardRow(icon: "bell", title: "Notifications")
                }
                
                NavigationLink { EvaluationsView() } label: {
                    DashboardRow(icon: "star", title: "Evaluations")
                }
                
                NavigationLink { ParrainageView() } label: {
                    DashboardRow(icon: "heart.text.square", title: "Parrainage", muted: true)
                }
                
                PrimaryCTAButton(title: "Demande d’aide", icon: "hand.raised.fill") {
                }
                .padding(.top, 8)
                .navigationTitle("Tableau de board")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        init() {
            _userSession = State(initialValue: UserSession())
        }
    }



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self, ServiceClass.self, configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        
        return DashboardView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
        
    }
}
