//
//  ConversationView.swift
//  SolidAide
//
//  Created by apprenant76 on 31/10/2025.
//
import SwiftUI
import SwiftData

struct ConversationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ServiceClass.startDate, order: .reverse) private var services: [ServiceClass]
    @Query private var allChats: [ChatClass]
    @State var showingAddService = false
    @State private var messageText = ""
    @FocusState private var isInputFocused: Bool
    
    let contactInfo: ProfileClass
    let currentUser: UserClass?

    var currentUserId: UUID? {
        currentUser?.id
    }

    var conversationMessages: [ChatClass] {
        guard let contactUserId = contactInfo.userId?.id else { return [] }
        guard let currentUserId = currentUserId else { return [] }
        
        return allChats
            .filter { chat in
                (chat.sender.id == currentUserId && chat.recipient.id == contactUserId) ||
                (chat.sender.id == contactUserId && chat.recipient.id == currentUserId)
            }
            .sorted(by: { $0.dateTime < $1.dateTime })
    }
    
    var body: some View {
        NavigationStack {
        VStack(spacing: 0) {
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundStyle(.deepBlue)
                    Image(contactInfo.imageURL ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading) {
                    Text(contactInfo.pseudo)
                        .font(.headline)
                        .bold()
                    Text("En ligne")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                
                Spacer()
                ButtonAddServiceExtView(showingAddService: $showingAddService)
                
            }
            .padding()
            .background(Color(.deepBlue.opacity(0.1)))
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(conversationMessages) { message in
                        MessageBubble(
                            message: message,
                            isCurrentUser: message.sender.id == currentUserId
                        )
                    }
                   Spacer()
                }
                .padding()
            }
        }
            HStack{
                Spacer()
                NavigationLink{
                    FeedBackView()
                } label:{
                    HStack{
                        Image(systemName:"pencil.and.list.clipboard")
                        Text("Évaluer le service !")
                    }
                    .padding(12)
                    .background(.goldenYellow)
                    .foregroundStyle(.black)
                    .cornerRadius(32)
                    .font(.system(size: 18))
                    .bold()
                }
            }
            // clavier
            HStack(spacing: 12) {
                TextField("Écrire un message...", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading, 8)
                    .focused($isInputFocused)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(messageText.isEmpty ? .gray : .goldenYellow)
                }
                .disabled(messageText.isEmpty)
                .padding(.trailing, 8)
            }
            .padding(.vertical, 8)
            .background(Color(.deepBlue.opacity(0.1)))
            .onAppear {
                // 🚀 Déclenchement du focus
                // Vous pouvez ajouter un petit délai pour être sûr que la vue est prête,
                // surtout si elle apparaît après une navigation ou une transition.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isInputFocused = true
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(isPresented: $showingAddService) {
            ServiceEditView(viewModel: ServiceFormViewModel(userSession: currentUser))
        }
    }
    
    // function pour envoyer des messages
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty,
              let currentUser = currentUser,
              let contactUser = contactInfo.userId else {
            return
        }
        
        let newMessage = ChatClass(
            dateTime: Date(),
            sender: currentUser,
            recipient: contactUser,
            message: messageText
        )
        
        modelContext.insert(newMessage)
        try? modelContext.save()
        
        messageText = ""
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
    
    let descriptor = FetchDescriptor<ProfileClass>()
    let profiles = try! context.fetch(descriptor)
    
    let userDescriptor = FetchDescriptor<UserClass>()
    let users = try! context.fetch(userDescriptor)
    
    return ConversationView(contactInfo: profiles[0], currentUser: users[2])
        .modelContainer(container)
}
