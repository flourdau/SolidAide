//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//
//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    /*
     USER FICTIF
     */
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "marie.dupont@email.fr"
    }) var usersFound: [UserClass]
    @State var userSession: UserSession
//

    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [ProfileClass]
    @Query private var chats: [ChatClass]
    
    @State private var messageType = "Tous"
    @State private var searchMessages: String = ""
    let status = ["Tous", "Non Lus", "Favoris"]
        
    var filteredProfiles: [ProfileClass] {
            // user logge de @Query USER FICTIF
            guard let currentUser = usersFound.first, let myProfile = currentUser.profileId else {
                return []
            }

            // Fait la liste des ID des contacts d'user
            let contactUserIDs = myProfile.contacts?.map { $0.id } ?? []
            
            // profils des contacts
            let contactProfiles = profiles.filter { profile in
                guard let profileUserId = profile.userId?.id else { return false }
                return contactUserIDs.contains(profileUserId)
            }

            switch messageType {
            case "Tous":
                return contactProfiles

            case "Non Lus":
                return contactProfiles.filter { profile in
                    chats.contains { chat in
                        chat.sender.id == profile.userId?.id &&
                        chat.recipient.id == currentUser.id &&
                        chat.isRead == false
                    }
                }

            case "Favoris":
                // prend la liste des ID favoris d'user
                let favoriteUserIDs = myProfile.favorite?.map { $0.id } ?? []
                
                // filtre la liste des favoris
                return profiles.filter { profile in
                    guard let profileUserId = profile.userId?.id else { return false }
                    return favoriteUserIDs.contains(profileUserId)
                }
                
            default:
                return contactProfiles
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
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }

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
                                                    $0.sender.id == contactInfo.userId?.id ||          $0.recipient.id == contactInfo.userId?.id                                                })
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
                                         $0.sender.id == contactInfo.userId?.id ||
                                         $0.recipient.id == contactInfo.userId?.id
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
            .navigationTitle("Bienvenue  \(userSession.currentUser?.profileId?.pseudo ?? "") ")

//            .navigationTitle("Messagerie")
            .searchable(text: $searchMessages, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un contact")
        }
    }

    init() {
        _userSession = State(initialValue: UserSession())
    }
}
    

#Preview {
//    ChatView()
//        .modelContainer(for: [
//            UserClass.self,
//            ProfileClass.self,
//            ChatClass.self,
//            ServiceClass.self,
//            TimeBankClass.self
//        ])
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self,
                                           ProfileClass.self,
                                           ServiceClass.self,
                                           ChatClass.self,
                                           TimeBankClass.self,
                                           configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        
        return ChatView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}

