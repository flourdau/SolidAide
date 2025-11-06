import SwiftUI
import SwiftData

// ---------------------------------------------------------------
// MARK: – Helpers (outside the view body)
// ---------------------------------------------------------------
fileprivate func resolveCurrentUser(
    session: UserSession,
    users: [UserClass],
    loggedInEmail: String
) -> UserClass? {
    session.currentUser ?? users.first { $0.logIn == loggedInEmail }
}

// Returns the most recent chat between two users.
fileprivate func latestChat(
    between userId: UUID,
    and contactId: UUID,
    in chats: [ChatClass]
) -> ChatClass? {
    chats
        .filter {
            ($0.sender.id == userId && $0.recipient.id == contactId) ||
            ($0.sender.id == contactId && $0.recipient.id == userId)
        }
        .max(by: { $0.dateTime < $1.dateTime })
}

// ---------------------------------------------------------------
// MARK: – ChatView
// ---------------------------------------------------------------
struct ChatView: View {
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    @Query private var usersFound: [UserClass]
    @Query private var profiles: [ProfileClass]

    // All chats – we’ll filter manually because we need the current user id.
    @Query private var allChats: [ChatClass]

    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var modelContext

    @State private var messageType = "Tous"
    @State private var searchText = ""

    private let status = ["Tous", "Non Lus", "Favoris"]

    // -----------------------------------------------------------------
    // Current user (taken from the shared session or fallback)
    // -----------------------------------------------------------------
    private var currentUser: UserClass? {
        resolveCurrentUser(session: userSession,
                           users: usersFound,
                           loggedInEmail: loggedInEmail)
    }

    // -----------------------------------------------------------------
    // Contacts that belong to the current user (derived from profile)
    // -----------------------------------------------------------------
    private var myProfile: ProfileClass? {
        currentUser?.profileId
    }

    private var contactIDs: Set<UUID> {
        guard let contacts = myProfile?.contacts else { return [] }
        return Set(contacts.map { $0.id })
    }

    private var favoriteIDs: Set<UUID> {
        guard let favs = myProfile?.favorite else { return [] }
        return Set(favs.map { $0.id })
    }

    // -----------------------------------------------------------------
    // Base list of contacts (only those that are in the user's contact list)
    // -----------------------------------------------------------------
    private var baseContacts: [ProfileClass] {
        profiles.filter { profile in
            guard let uid = profile.userId?.id else { return false }
            return contactIDs.contains(uid)
        }
    }

    // -----------------------------------------------------------------
    // Chats that are unread (used for the “Non Lus” tab)
    // -----------------------------------------------------------------
    private var nonReadContactIDs: Set<UUID> {
        guard let uid = currentUser?.id else { return [] }
        var ids = Set<UUID>()
        for chat in allChats where !chat.isRead {
            if chat.sender.id == uid {
                ids.insert(chat.recipient.id)
            } else if chat.recipient.id == uid {
                ids.insert(chat.sender.id)
            }
        }
        return ids
    }

    // -----------------------------------------------------------------
    // Filtered contacts according to the selected segment
    // -----------------------------------------------------------------
    private var filteredContacts: [ProfileClass] {
        switch messageType {
        case "Tous":
            return baseContacts
        case "Non Lus":
            return baseContacts.filter {
                guard let uid = $0.userId?.id else { return false }
                return nonReadContactIDs.contains(uid)
            }
        case "Favoris":
            return baseContacts.filter {
                guard let uid = $0.userId?.id else { return false }
                return favoriteIDs.contains(uid)
            }
        default:
            return baseContacts
        }
    }

    // -----------------------------------------------------------------
    // Apply the free‑text search
    // -----------------------------------------------------------------
    private var displayedContacts: [ProfileClass] {
        guard !searchText.isEmpty else { return filteredContacts }
        return filteredContacts.filter {
            $0.pseudo.localizedCaseInsensitiveContains(searchText)
        }
    }

    // -----------------------------------------------------------------
    // Body – UI composition only
    // -----------------------------------------------------------------
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Type", selection: $messageType) {
                    ForEach(status, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                .padding()

                Divider()

                ScrollView {
                    let list = displayedContacts
                    ForEach(list) { contact in
                        NavigationLink {
                            ConversationView(contactInfo: contact)
                        } label: {
                            ContactRow(
                                contact: contact,
                                latestChat: latestChat(
                                    between: currentUser?.id ?? UUID(),
                                    and: contact.userId?.id ?? UUID(),
                                    in: allChats)
                            )
                        }
                        .tint(.primary)

                        Divider()
                    }
                }
            }
            .navigationTitle(
                "Bienvenue, \(userSession.currentUser?.profileId?.pseudo ?? "") "
            )
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Rechercher un contact")
        }
        .onAppear {
            // Ensure the shared session is populated (fallback to stored email)
            if let fallback = usersFound.first(where: { $0.logIn == loggedInEmail }),
               userSession.currentUser?.id != fallback.id {
                userSession.currentUser = fallback
            }
        }
    }
}

// ---------------------------------------------------------------
// MARK: – Row view used inside the scroll view
// ---------------------------------------------------------------
private struct ContactRow: View {
    let contact: ProfileClass
    let latestChat: ChatClass?

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            // Avatar
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.deepBlue)

                Image(contact.imageURL ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }

            // Textual info
            VStack(alignment: .leading, spacing: 5) {
                Text(contact.pseudo)
                    .font(.headline)

                if let chat = latestChat {
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

            // Time of the latest message (if any)
            if let chat = latestChat {
                Text(chat.dateTime, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(10)
    }
}
