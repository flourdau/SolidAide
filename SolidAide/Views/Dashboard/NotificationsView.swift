import SwiftUI
import SwiftData

// ---------------------------------------------------------------
//  NotificationsView – affiche le nombre de messages non lus
//  et liste ces messages (avec un petit aperçu du texte)
// ---------------------------------------------------------------
struct NotificationsView: View {
    // -----------------------------------------------------------------
    // 1️⃣  Données SwiftData
    // -----------------------------------------------------------------
    @Query private var chats: [ChatClass]          // Tous les chats
    @Query private var users: [UserClass]          // Tous les utilisateurs

    // -----------------------------------------------------------------
    // 2️⃣  Environnement – session partagée
    // -----------------------------------------------------------------
    @EnvironmentObject private var userSession: UserSession
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    // -----------------------------------------------------------------
    // 3️⃣  Utilisateur courant (fallback sur l’e‑mail stocké)
    // -----------------------------------------------------------------
    private var currentUser: UserClass? {
        userSession.currentUser ??
        users.first { $0.logIn == loggedInEmail }
    }

    // -----------------------------------------------------------------
    // 4️⃣  Messages non lus destinés à l’utilisateur actuel
    // -----------------------------------------------------------------
    private var unreadMessages: [ChatClass] {
        guard let uid = currentUser?.id else { return [] }
        return chats.filter { chat in
            chat.recipient.id == uid && !chat.isRead
        }
        .sorted { $0.dateTime > $1.dateTime }   // du plus récent au plus ancien
    }

    // -----------------------------------------------------------------
    // 5️⃣  Corps de la vue
    // -----------------------------------------------------------------
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // ---------------------------------------------------------
            // Titre avec le compteur
            // ---------------------------------------------------------
            Text("Vous avez \(unreadMessages.count) nouveau\(unreadMessages.count > 1 ? "x" : "x") message\(unreadMessages.count > 1 ? "s" : "") :")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)

            // ---------------------------------------------------------
            // Liste des messages non lus
            // ---------------------------------------------------------
            if unreadMessages.isEmpty {
                Text("Aucun message non lu.")
                    .foregroundStyle(.secondary)
            } else {
                List {
                    ForEach(unreadMessages) { chat in
                        // Chaque ligne montre l’expéditeur, un extrait du texte et l’heure
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(chat.sender.logIn)
                                    .font(.subheadline)
                                    .foregroundStyle(.accent)
                                Spacer()
                                Text(chat.dateTime, style: .time)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Text(chat.message)
                                .font(.body)
                                .lineLimit(2)
                                .foregroundStyle(.primary)
                        }
                        .padding(.vertical, 4)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Marquer le message comme lu et ouvrir la conversation
                            chat.isRead = true
                            try? context.save()
                            // Vous pouvez pousser vers la vue de conversation si vous le désirez
                            // Par exemple : navigationLink(to: ConversationView(...))
                        }
                    }
                }
                .listStyle(.plain)
                .frame(maxHeight: .infinity)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    // -----------------------------------------------------------------
    // 6️⃣  Contexte SwiftData (pour sauvegarder le statut lu)
    // -----------------------------------------------------------------
    @Environment(\.modelContext) private var context
}

// ---------------------------------------------------------------
//  Preview
// ---------------------------------------------------------------
#Preview {
    NavigationStack {
        NotificationsView()
            .environmentObject(UserSession())
    }
}
