import SwiftUI
import SwiftData

public let kShowAdminTabKey = "showAdminTab"

struct SolidAideView: View {
    @AppStorage(kShowAdminTabKey) private var showAdminTab: Bool = false
    @EnvironmentObject private var userSession: UserSession
    @Query(sort: \UserClass.logIn) private var usersFound: [UserClass]

    var body: some View {
        let currentUser = usersFound.first { $0.logIn == UserDefaults.standard.string(forKey: "loggedInEmail") }

        Group {
            if let user = currentUser {
                TabView {
                    MapView()
                        .tabItem {
                            Text("Rechercher")
                            Image(systemName: "magnifyingglass")
                        }
                        .environmentObject(userSession)

                    DashboardView()
                        .tabItem {
                            Text("Tableau de bord")
                            Image(systemName: "square.grid.2x2.fill")
                        }

                    ChatView()
                        .tabItem {
                            Text("Messagerie")
                            Image(systemName: "bubble")
                        }

                    if showAdminTab {
                        AdminDataBaseView()
                            .tabItem {
                                Text("Admin")
                                Image(systemName: "arrow.2.circlepath.circle")
                            }
                    }
                }
                .onAppear {
                    if userSession.currentUser == nil {
                        userSession.currentUser = user
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)

                    Text("Aucun compte utilisateur trouvé.")
                        .font(.headline)

                    Text("""
                         Vérifiez que l’adresse e‑mail enregistrée (« \(UserDefaults.standard.string(forKey: "loggedInEmail") ?? "‑") ») \
                         correspond à un utilisateur présent dans le seed de données.
                         """)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
    }
}
