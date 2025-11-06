//
//  ChatView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//
import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    })
    var usersFound: [UserClass]
    @Query private var profiles: [ProfileClass]
    @Query private var chats: [ChatClass]
    @State private var messageType = "Tous"
    @State private var searchMessages: String = ""
    let status = ["Tous", "Non Lus", "Favoris"]
    
    var filteredProfiles: [ProfileClass] {
        guard let currentUser = usersFound.first, let myProfile = currentUser.profileId else {
            return []
        }
        
        let contactUserIDs = myProfile.contacts?.map { $0.id } ?? []
        
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
            let favoriteUserIDs = myProfile.favorite?.map { $0.id } ?? []
            
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
    
    private func getLatestChatWith(_ contactInfo: ProfileClass) -> ChatClass? {
        guard let currentUserId = usersFound.first?.id,
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
        
        NavigationStack {
            VStack(spacing: 0) {
                VStack{
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
                
                ScrollView {
                    ForEach(searchContact) { contactInfo in
                        NavigationLink {
                            ConversationView(contactInfo: contactInfo, currentUser: usersFound[0])
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
            .navigationTitle("Messagerie")
            .searchable(text: $searchMessages, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un contact")
        }
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

