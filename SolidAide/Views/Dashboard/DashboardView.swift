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
    
    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }
        
        NavigationStack {
            NavigationLink {
                SettingsView()
            } label: {
                ZStack{
                    Rectangle()
                        .fill(Color("deepBlue")).opacity(0.8)
                        .cornerRadius(15)
                        .frame(height: 30)
                    HStack{
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.white)
                        Text("Paramètres")
                            .foregroundStyle(Color.white)
                            .applyAppFont(18)
                    }
                    .padding(.horizontal, 12)
                }
            }
            
            if let p = usersFound[0].profileId {
                NavigationLink {
                    ProfileDetailView(profile: p)
                } label: {
                    ProfileCardView(profile: p)
                }
                .tint(.black)
            } else {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.secondarySystemBackground))
                    .overlay(Text("Créer mon profil").padding())
                    .frame(height: 72)
            }
            
            NavigationLink {
                TimeBankView()
            } label: {
                DashboardRow(
                    icon: "clock.badge.checkmark",
                    title: "Banque de temps",
                    trailing: Text(String("\(usersFound[0].balance) heures")).foregroundStyle(.mintGreen)
                    
                )
                .tint(.black)
            }
            
            NavigationLink { DemandesView() } label: {
                DashboardRow(icon: "hand.wave", title: "Demandes de service")
                    .tint(.black)
            }
            
            NavigationLink { ParrainageView() } label: {
                DashboardRow(icon: "heart.text.square", title: "Parrainage", muted: true)
                    .tint(.black)
            }
            
            VStack {
                Spacer()
                ButtonAddServiceExtView(showingAddService: $showingAddService)
                    .padding(.bottom, 20)
            }
            .navigationTitle("Tableau de bord")
        }
        .sheet(isPresented: $showingAddService) {
            ServiceEditView(viewModel: ServiceFormViewModel(userSession: usersFound[0]))
        }
        .padding(.horizontal, 16)
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
