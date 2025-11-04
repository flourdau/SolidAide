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
    @State var showingAddService = false

    
    @Environment(\.modelContext) private var context
    //    @Environment(CurrentProfileModel.self) private var profileModel
    @Query(sort: \ProfileClass.pseudo) private var profiles: [ProfileClass]
    //    @Query(sort: \TimeBankClass.updatedAt, order: .reverse) var timeBank: [TimeBankClass]
    //    init() {}
    //    private var currentProfile: ProfileClass? { profileModel.profile ?? profiles.first }
    //    private var timeDeltaText: String {
    //        let limit = Date().addingTimeInterval(-24*3600)
    //        let deltaMinutes = timeBank
    //            .filter { $0.updatedAt >= limit }
    //            .reduce(0) { $0 + $1.deltaMinutes }
    //        return "\(deltaMinutes.timeBankDisplay) depuis 24 heures"
    //    }
    
    //    private var totalText: String {
    //        let total = timeBank.reduce(0) { $0 + $1.deltaMinutes }
    //        return total.timeBankDisplay.replacingOccurrences(of: "+", with: "")
    //    }
    // let profileInfo: ProfileClass
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }

        NavigationStack {
            //            VStack(spacing: 16) {
            //                Text("Tableau de bord")
            //                    .font(.title2.weight(.semibold))
            //
            if let p = usersFound[0].profileId {
                NavigationLink {
                    ProfileDetailView(profile: p)
                } label: {
                    ProfileCardView(profile: p)
                }
            } else {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.secondarySystemBackground))
                    .overlay(Text("Créer mon profil").padding())
                    .frame(height: 72)
            }
            //            }
            //            .padding(.horizontal, 16)
            
            NavigationLink {
                TimeBankView()
            } label: {
                DashboardRow(
                    icon: "clock.badge.checkmark",
                    title: "Banque de temps",
                    //                    trailing: Text(timeDeltaText).foregroundStyle(.green)
//                    trailing: Text("TEST").foregroundStyle(.green)
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

            ButtonAddServiceExtView(showingAddService: $showingAddService)

        }
        .sheet(isPresented: $showingAddService) {
            ServiceEditView(viewModel: ServiceFormViewModel(userSession: usersFound[0]))
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
