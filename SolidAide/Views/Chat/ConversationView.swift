import SwiftUI
import SwiftData

struct ConversationView: View {
    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var modelContext
    @Query private var allChats: [ChatClass]
    @Query private var users: [UserClass]

    @State private var showingAddService = false
    @State private var messageText = ""

    let contactInfo: ProfileClass

    private var currentUser: UserClass? {
        guard let email = UserDefaults.standard.string(forKey: "loggedInEmail") else { return nil }
        return users.first { $0.logIn == email }
    }

    private var currentUserId: UUID? { currentUser?.id }

    private var conversationMessages: [ChatClass] {
        guard let contactId = contactInfo.userId?.id,
              let currentId = currentUserId else { return [] }

        return allChats
            .filter { chat in
                (chat.sender.id == currentId && chat.recipient.id == contactId) ||
                (chat.sender.id == contactId && chat.recipient.id == currentId)
            }
            .sorted { $0.dateTime < $1.dateTime }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
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

            // Messages
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(conversationMessages) { message in
                        MessageBubble(message: message,
                                      isCurrentUser: message.sender.id == currentUserId)
                    }
                }
                .padding()
            }

            // Composer
            HStack(spacing: 12) {
                TextField("Écrire un message...", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading, 8)

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
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddService) {
            ServiceEditView(viewModel: ServiceFormViewModel(userSession: currentUser))
        }
        .onAppear { markUnreadMessagesAsRead() }
    }

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty,
              let currentUser = currentUser,
              let contactUser = contactInfo.userId else { return }

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

    private func markUnreadMessagesAsRead() {
        guard let contactId = contactInfo.userId?.id,
              let currentId = currentUserId else { return }

        let unread = allChats.filter { chat in
            chat.sender.id == contactId &&
            chat.recipient.id == currentId &&
            !chat.isRead
        }

        guard !unread.isEmpty else { return }

        for chat in unread { chat.isRead = true }
        try? modelContext.save()
    }
}
