//
//  AdminDataBaseView.swift
//  SolidAide
//
//  Created by apprenant78 on 30/10/2025.
//

import SwiftUI
import SwiftData
import MapKit

struct AdminDataBaseView: View {
    @Environment(\.modelContext) private var context
    @Query var users: [UserClass]
    @Query var profiles: [ProfileClass]
    @Query var chats: [ChatClass]
    @Query var services: [ServiceClass]
    @Query var timeBanks: [TimeBankClass]
    
    func ResetDataBaseUserFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<UserClass>()
            let usersToDelete = try context.fetch(fetchDescriptor)
            
            for user in usersToDelete {
                context.delete(user)
            }
            print("Base de données User réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données User: \(error)")
        }
    }
    
    func ResetDataBaseProfileFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<ProfileClass>()
            let profilesToDelete = try context.fetch(fetchDescriptor)
            
            for profile in profilesToDelete {
                context.delete(profile)
            }
            print("Base de données Profile réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données Profile: \(error)")
        }
    }
    
    func ResetDataBaseChatFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<ChatClass>()
            let chatsToDelete = try context.fetch(fetchDescriptor)
            
            for chat in chatsToDelete {
                context.delete(chat)
            }
            print("Base de données Chat réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données Chat: \(error)")
        }
    }
    
    func ResetDataBaseServiceFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<ServiceClass>()
            let servicesToDelete = try context.fetch(fetchDescriptor)
            
            for service in servicesToDelete {
                context.delete(service)
            }
            print("Base de données Service réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données Service: \(error)")
        }
    }
    
    func ResetDataBaseTimeBankFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<TimeBankClass>()
            let timeBanksToDelete = try context.fetch(fetchDescriptor)
            
            for timeBank in timeBanksToDelete {
                context.delete(timeBank)
            }
            print("Base de données TimeBank réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données TimeBank: \(error)")
        }
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                //  USERS
                if !users.isEmpty {
                    VStack (alignment: .leading){
                        HStack  {
                            Spacer()
                            Button("USERS") {
                                ResetDataBaseUserFunc(context: context)
                            }
                            .foregroundStyle(.white)
                            .padding(24)
                            .background(.orange)
                            .cornerRadius(16)
                        }
                        
                        ForEach(users, id: \.self) { user in
                            Text(user.logIn)
                                .font(.headline)
                        }

                    }
                }
                
                
                //  PROFILES
                if !profiles.isEmpty {
                    VStack (alignment: .leading){
                        HStack  {
                            Spacer()
                            
                            Button("PROFILES") {
                                ResetDataBaseProfileFunc(context: context)
                            }
                            .foregroundStyle(.white)
                            .padding(24)
                            .background(.orange)
                            .cornerRadius(16)
                            
                        }
                        
                        ForEach(profiles, id: \.self) { profile in
                            HStack {
                                Text(profile.pseudo)
                                    .font(.headline)
                                
                                Text("\(String(profile.profilePosition?.latitude ?? 0.0)) - \(String(profile.profilePosition?.longitude ?? 0.0))")
                                    .font(.headline)
                            }
                        }

                    }
                }
                
                
                //  CHATS
                if !chats.isEmpty {
                    VStack (alignment: .leading){
                        HStack  {
                            Spacer()
                            
                            Button("CHAT") {
                                ResetDataBaseChatFunc(context: context)
                            }
                            .foregroundStyle(.white)
                            .padding(24)
                            .background(.orange)
                            .cornerRadius(16)
                            
                        }
                        
                        ForEach(chats, id: \.self) { chat in
                            HStack {
                                Text(chat.message)
                                    .font(.headline)
                            }
                        }

                    }
                }
                
                
                //  SERVICES
                if !services.isEmpty {
                    VStack (alignment: .leading){
                        HStack  {
                            Spacer()
                            
                            Button("SERVICES") {
                                ResetDataBaseServiceFunc(context: context)
                            }
                            .foregroundStyle(.white)
                            .padding(24)
                            .background(.orange)
                            .cornerRadius(16)
                            
                        }
                        
                        ForEach(services, id: \.self) { service in
                            HStack {
                                Text(service.serviceDescription)
                                    .font(.headline)
                            }
                        }
                        
                    }
                }
                
                
                // TIMEBANK
                if !timeBanks.isEmpty {
                    VStack (alignment: .leading){
                        HStack  {
                            Spacer()
                            
                            Button("TIMEBANK") {
                                ResetDataBaseTimeBankFunc(context: context)
                            }
                            .foregroundStyle(.white)
                            .padding(24)
                            .background(.orange)
                            .cornerRadius(16)
                            
                        }
                        
                        ForEach(timeBanks, id: \.self) { timeBank in
                            HStack {
                                Text(timeBank.title)
                                    .font(.headline)
                            }
                        }

                    }
                }
                
                
            }
            
            //  BUTTONS
            HStack {
                Button("Générer") {
                    GenerateDataBaseFunc(context: context)
                }
                .foregroundStyle(.white)
                .padding(24)
                .background(.green)
                .cornerRadius(16)
                
                Button("Delete All!") {
                    ResetDataBaseUserFunc(context: context)
                    ResetDataBaseProfileFunc(context: context)
                    ResetDataBaseChatFunc(context: context)
                    ResetDataBaseServiceFunc(context: context)
                    ResetDataBaseTimeBankFunc(context: context)
                }
                .foregroundStyle(.white)
                .padding(24)
                .background(.red)
                .cornerRadius(16)
                
            }
        }
        
    }
}

#Preview {
    //    AdminDataBaseView()
    //        .modelContainer(for: [
    //            UserClass.self,
    //            ProfileClass.self,
    //            ChatClass.self,
    //            ServiceClass.self,
    //            TimeBankClass.self
    //        ])
    
    do {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self, configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)

        return AdminDataBaseView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
        
    }
}
