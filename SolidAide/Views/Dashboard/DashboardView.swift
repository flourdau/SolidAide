import SwiftUI
import SwiftData

struct DashboardView: View {
    @AppStorage("loggedInEmail") private var loggedInEmail: String = ""

    @Query(sort: \UserClass.logIn) private var usersFound: [UserClass]

    @EnvironmentObject private var userSession: UserSession

    @State private var showingAddService = false
    @Environment(\.modelContext) private var context

    @Query(sort: \ProfileClass.pseudo) private var profiles: [ProfileClass]

    var body: some View {
        let currentUser = usersFound.first { $0.logIn == loggedInEmail }

        Group {
            if let user = currentUser {
                NavigationStack {
                    // ---------- PROFIL CARD ----------
                    if let profile = user.profileId {
                        NavigationLink {
                            ProfileDetailView(profile: profile)
                        } label: {
                            ProfileCardView(profile: profile)
                        }
                        .tint(.black)
                    } else {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.secondarySystemBackground))
                            .overlay(Text("Créer mon profil").padding())
                            .frame(height: 72)
                    }

                    // ---------- BANQUE DE TEMPS ----------
                    NavigationLink {
                        TimeBankView()
                    } label: {
                        DashboardRow(
                            icon: "clock.badge.checkmark",
                            title: "Banque de temps",
                            trailing: Text("\(user.balance) heures")
                                .foregroundStyle(.mintGreen)
                        )
                        .tint(.black)
                    }

                    // ---------- AUTRES LIENS ----------
                    NavigationLink { ServicesOffertsView() } label: {
                        DashboardRow(icon: "hand.raised", title: "Services proposés")
                            .tint(.black)
                    }

                    // ---- NOUVEAU LIEN : LISTE DES DEMANDES DE SERVICE ----
                    NavigationLink {
                        ServiceListView()          // ← vue qui liste les services
                    } label: {
                        DashboardRow(icon: "hand.wave", title: "Demandes de service")
                            .tint(.black)
                    }

                    NavigationLink { NotificationsView() } label: {
                        DashboardRow(icon: "bell", title: "Notifications")
                            .tint(.black)
                    }

                    NavigationLink { EvaluationsView() } label: {
                        DashboardRow(icon: "star", title: "Évaluations")
                            .tint(.black)
                    }

                    NavigationLink { ParrainageView() } label: {
                        DashboardRow(icon: "heart.text.square", title: "Parrainage", muted: true)
                            .tint(.black)
                    }

                    // ---------- BOUTON « Demander de l’aide » ----------
                    VStack {
                        Spacer()
                        ButtonAddServiceExtView(showingAddService: $showingAddService)
                    }
                    .navigationTitle("Tableau de bord")
                }
                .sheet(isPresented: $showingAddService) {
                    ServiceEditView(viewModel: ServiceFormViewModel(userSession: user))
                }
                .padding(.horizontal, 16)

            } else {
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)

                    Text("Aucun compte utilisateur trouvé.")
                        .font(.headline)

                    Text("""
                         Vérifiez que l’adresse e‑mail enregistrée (« \(loggedInEmail) ») \
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
