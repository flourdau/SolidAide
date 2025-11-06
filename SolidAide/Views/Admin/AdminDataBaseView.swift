import SwiftUI
import SwiftData
import MapKit

struct AdminDataBaseView: View {
    @EnvironmentObject private var userSession: UserSession
    @Environment(\.modelContext) private var context

    @Query private var users: [UserClass]
    @Query private var profiles: [ProfileClass]
    @Query private var chats: [ChatClass]
    @Query private var services: [ServiceClass]
    @Query private var timeBanks: [TimeBankClass]

    @AppStorage(kShowAdminTabKey) private var showAdminTab: Bool = false
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    // -----------------------------------------------------------------
    // MARK: – Reset helpers (utilisent l’extension deleteAll)
    // -----------------------------------------------------------------
    private func resetUsers()   { try? context.deleteAll(of: UserClass.self) }
    private func resetProfiles(){ try? context.deleteAll(of: ProfileClass.self) }
    private func resetChats()   { try? context.deleteAll(of: ChatClass.self) }
    private func resetServices(){ try? context.deleteAll(of: ServiceClass.self) }
    private func resetTimeBanks(){ try? context.deleteAll(of: TimeBankClass.self) }

    // -----------------------------------------------------------------
    var body: some View {
        NavigationStack {
            List {
                // ==== USERS ==================================================
                if !users.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("USERS") { resetUsers() }
                                .foregroundStyle(.white)
                                .padding(24)
                                .background(.orange)
                                .cornerRadius(16)
                        }
                        ForEach(users, id: \.self) { user in
                            Text(user.logIn).font(.headline)
                        }
                    }
                }

                // ==== PROFILES ==============================================
                if !profiles.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("PROFILES") { resetProfiles() }
                                .foregroundStyle(.white)
                                .padding(24)
                                .background(.orange)
                                .cornerRadius(16)
                        }
                        ForEach(profiles, id: \.self) { profile in
                            HStack {
                                Text(profile.pseudo).font(.headline)
                                Text("\(String(profile.profilePosition?.latitude ?? 0.0)) - \(String(profile.profilePosition?.longitude ?? 0.0))")
                                    .font(.headline)
                            }
                        }
                    }
                }

                // ==== CHATS =================================================
                if !chats.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("CHATS") { resetChats() }
                                .foregroundStyle(.white)
                                .padding(24)
                                .background(.orange)
                                .cornerRadius(16)
                        }
                        ForEach(chats, id: \.self) { chat in
                            Text(chat.message).font(.headline)
                        }
                    }
                }

                // ==== SERVICES ==============================================
                if !services.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("SERVICES") { resetServices() }
                                .foregroundStyle(.white)
                                .padding(24)
                                .background(.orange)
                                .cornerRadius(16)
                        }
                        ForEach(services, id: \.self) { service in
                            Text(service.serviceDescription).font(.headline)
                        }
                    }
                }

                // ==== TIMEBANK ==============================================
                if !timeBanks.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("TIMEBANK") { resetTimeBanks() }
                                .foregroundStyle(.white)
                                .padding(24)
                                .background(.orange)
                                .cornerRadius(16)
                        }
                        ForEach(timeBanks, id: \.self) { tb in
                            Text(tb.title).font(.headline)
                        }
                    }
                }

                // ==== ACTION BUTTONS (Générer / Régénérer / Delete All) ====
                HStack {
                    // 1️⃣  Générer – insère le seed sans nettoyer
                    Button("Générer") {
                        GenerateDataBaseFunc(context: context)
                    }
                    .foregroundStyle(.white)
                    .padding(24)
                    .background(.green)
                    .cornerRadius(16)

                    // 2️⃣  Régénérer – vide tout puis regénère
                    Button("Régénérer la data") {
                        resetUsers()
                        resetProfiles()
                        resetChats()
                        resetServices()
                        resetTimeBanks()
                        GenerateDataBaseFunc(context: context)

                        // Réinitialiser la session (optionnel)
                        userSession.currentUser = nil
                        loggedInEmail = ""
                        showAdminTab = false
                    }
                    .foregroundStyle(.white)
                    .padding(24)
                    .background(.blue)
                    .cornerRadius(16)

                    // 3️⃣  Delete All – supprime tout sans regénérer
                    Button("Delete All!") {
                        resetUsers()
                        resetProfiles()
                        resetChats()
                        resetServices()
                        resetTimeBanks()
                        userSession.currentUser = nil
                        loggedInEmail = ""
                        showAdminTab = false
                    }
                    .foregroundStyle(.white)
                    .padding(24)
                    .background(.red)
                    .cornerRadius(16)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)
            }
            .onDisappear { showAdminTab = false }
        }
    }
}
