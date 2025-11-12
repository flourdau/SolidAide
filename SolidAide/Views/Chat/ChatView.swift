//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//
import SwiftUI
import SwiftData

struct ChatView: View {
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    @State var userSession: UserSession
    @Environment(\.modelContext) private var modelContext
    @Query private var chats: [ChatClass]
    @State private var messageType = "Tous"
    @State private var searchMessages: String = ""
    let status = ["Tous", "Non Lus", "Favoris"]
    
    private var currentUser: UserClass? {
        usersFound.first
    }
    
    private var allContactProfiles: [ProfileClass] {
        guard let myProfile = currentUser?.profileId,
              let myContacts = myProfile.contacts else {
    
            return []
        }
        
        return myContacts.compactMap { $0.profileId }
    }
    
    private var filteredProfiles: [ProfileClass] { // renomé
        let allContacts = allContactProfiles
    
        guard !allContacts.isEmpty,
              let currentUser = currentUser,
              let myProfile = currentUser.profileId else {
            return allContacts
        }
        
        switch messageType {
        case "Tous":
            return allContacts
            
        case "Non Lus":
            return allContacts.filter { profile in
                guard let profileUserId = profile.userId?.id else { return false }
                
                return chats.contains { chat in
                    chat.sender.id == profileUserId &&
                    chat.recipient.id == currentUser.id &&
                    chat.isRead == false
                }
            }
            
        case "Favoris":
            guard let favoriteUsers = myProfile.favorite else {
                return []
            }
            let favoriteUserIDs = favoriteUsers.map { $0.id }
            
            return allContacts.filter { profile in
                guard let profileUserId = profile.userId?.id else { return false }
                return favoriteUserIDs.contains(profileUserId)
            }
            
        default:
            return allContacts
        }
    }
    
    private var searchContact: [ProfileClass] {
         if searchMessages.isEmpty {
             return filteredProfiles
         } else {
             return filteredProfiles.filter {
                 $0.pseudo.localizedCaseInsensitiveContains(searchMessages)
             }
         }
    }
    

    private func getLatestChatWith(_ contactInfo: ProfileClass) -> ChatClass? {
        guard let currentUserId = currentUser?.id,
              let contactUserId = contactInfo.userId?.id else {
            return nil
        }
        
        return chats
            .filter { chat in
                (chat.sender.id == currentUserId && chat.recipient.id == contactUserId) ||
                (chat.sender.id == contactUserId && chat.recipient.id == currentUserId)
            }
            .sorted(by: { $0.dateTime > $1.dateTime })
            .first
    }

    var body: some View {
        let _ = DispatchQueue.main.async {
            if usersFound.first !== userSession.currentUser {
                userSession.currentUser = usersFound.first
            }
        }

        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    Picker("Type", selection: $messageType) {
                        ForEach(status, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                .background(.deepBlue.opacity(0.1))
                
                Divider()
                
                if currentUser == nil {
                    ContentUnavailableView {
                        Label("Chargement...", systemImage: "hourglass")
                    } description: {
                        Text("Veuillez patienter")
                    }
                }
                
                else if currentUser!.profileId == nil {
                    ContentUnavailableView {
                        Label("Chargement du profil...", systemImage: "person.circle.fill")
                    } description: {
                        Text("Veuillez patienter")
                    }
                }
                
                else if currentUser!.profileId!.contacts == nil {
                    ContentUnavailableView {
                        Label("Carregamento des contatos...", systemImage: "person.2.fill")
                    } description: {
                        Text("Veuillez patienter")
                    }
                }
                
                else if messageType == "Favoris" && currentUser!.profileId!.favorite == nil {
                    ContentUnavailableView {
                        Label("Carregamento des favoris...", systemImage: "star.fill")
                    } description: {
                        Text("Veuillez patienter")
                    }
                }
                
                else if currentUser!.profileId!.contacts?.isEmpty == true {
                    ContentUnavailableView {
                        Label("Aucun contact", systemImage: "person.slash")
                    } description: {
                        Text("Vous n'avez pas encore de contacts")
                    }
                }
                
                else if allContactProfiles.isEmpty {
                    ContentUnavailableView {
                        Label("Finalizando...", systemImage: "hourglass")
                    } description: {
                        Text("Veuillez patienter")
                    }
                }
                
                else if searchContact.isEmpty {
                    if !searchMessages.isEmpty {
                        ContentUnavailableView.search(text: searchMessages)
                    } else {
                        ContentUnavailableView {
                            Label("Aucun contact", systemImage: "person.slash.fill")
                        } description: {
                            Text("Nenhum contato encontrado para o filtro \"\(messageType)\".")
                        }
                    }
                }
                
                else {
                    ScrollView {
                        ForEach(searchContact) { contactInfo in
                            NavigationLink {
                                ConversationView(contactInfo: contactInfo, currentUser: currentUser)
                            } label: {
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
                                        
                                        if let chat = getLatestChatWith(contactInfo) {
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
                                    
                                    if let chat = getLatestChatWith(contactInfo) {
                                        Text(chat.dateTime, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(10)
                            }
                            .tint(.primary)
                            
                            Divider()
                        }
                    }
                }
            }
            .navigationTitle("Messagerie")
            .searchable(text: $searchMessages, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un contact")
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
        
        return ChatView()
            .modelContainer(container)
        
    } catch {
        fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}
