//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    //@Environment(\.modelContext) private var modelContext
    @Query private var profiles: [ProfileClass]
    @Query private var chats: [ChatClass]
    
    @State private var messageType = "Tous"
    @State private var searchMessages: String = ""
    let status = ["Tous", "Non Lus", "Favoris"]

    var currentUserId: UUID? {
        profiles.first(where: { $0.pseudo == "Marie D." })?.userId.id
    }
        
    var filteredProfiles: [ProfileClass] {
        switch messageType {
        case "Tous":
            return profiles
        case "Non Lus":
            return profiles.filter { profile in
                chats.contains { chat in
            (chat.sender.id == profile.userId.id ||
            chat.recipient.id == profile.userId.id) &&
            chat.isRead == false
                    }
                }
        case "Favoris":
            // filtre les profiles favoris de l'user
            guard let currentUserId = currentUserId else { return [] }
                
            // trouve le profil de l'user
            guard let myProfile = profiles.first(where: { $0.userId.id == currentUserId }) else {
                    return []
                }
            // Retroune les users favoris
            return profiles.filter { profile in
                myProfile.favorite?.contains(where: { $0.id == profile.userId.id }) ?? false
                }
            default:
                return profiles
            }
        }
    
    private var searchContact: [ProfileClass]{
         if searchMessages.isEmpty {
             return filteredProfiles} else{
                 return filteredProfiles.filter {
                $0.pseudo.localizedCaseInsensitiveContains(searchMessages)}
             }
     }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Type", selection: $messageType) {
                    ForEach(status, id: \.self) {
                        Text($0)
                    }
                  
                }
                .pickerStyle(.segmented)
                .padding()
                
                Divider()
                
                ScrollView {
                    ForEach(searchContact) { contactInfo in
                        HStack(alignment: .top, spacing: 20) {
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(.deepBlue)
                                Image(contactInfo.imageURL ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(contactInfo.pseudo)
                                    .font(.headline)
                                
                                if let chat = chats
                                                .filter({
                                                    $0.sender.id == contactInfo.userId.id ||
                                                    $0.recipient.id == contactInfo.userId.id
                                                })
                                                .sorted(by: { $0.dateTime > $1.dateTime })  
                                                .first {
                                                
                                                Text(chat.message)
                                                    .italic()
                                                    .foregroundColor(.gray)
                                                    .lineLimit(1)
                                            } else {
                                                Text("Aucun message")
                                                    .italic()
                                                    .foregroundColor(.gray)
                                            }
                                        }
                            
                            Spacer()
                            
                            if let chat = chats
                                     .filter({
                                         $0.sender.id == contactInfo.userId.id ||
                                         $0.recipient.id == contactInfo.userId.id
                                     })
                                     .sorted(by: { $0.dateTime > $1.dateTime })
                                     .first {
                                     
                                     Text(chat.dateTime, style: .time)
                                         .font(.caption)
                                         .foregroundColor(.gray)
                                 }
                             }
                        .padding(10)
                        
                        Divider()
                    }
                }
            }
            .navigationTitle("Messagerie")
            .searchable(text: $searchMessages, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un contact")
        }
    }
    
}
    

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: UserClass.self, ProfileClass.self, ChatClass.self, ServiceClass.self, TimeBankClass.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    GenerateDataBaseFunc(context: context)
    
    return ChatView()
        .modelContainer(container)
}
