import SwiftUI
import SwiftData

// ---------------------------------------------------------------
//  HistoricalTimeView – même affichage que la « Banque du temps »
// ---------------------------------------------------------------
struct HistoricalTimeView: View {
    // -----------------------------------------------------------------
    // 1️⃣  Données SwiftData (les entrées de la TimeBank)
    // -----------------------------------------------------------------
    @Query(sort: \TimeBankClass.date, order: .reverse) private var timeBanks: [TimeBankClass]

    // -----------------------------------------------------------------
    // 2️⃣  Corps de la vue – reproduit le layout de TimeBankView
    // -----------------------------------------------------------------
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // ---------------------------------------------------------
                // En‑tête
                // ---------------------------------------------------------


                // ---------------------------------------------------------
                // Liste des entrées (triées du plus récent au plus ancien)
                // ---------------------------------------------------------
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(timeBanks) { entry in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: entry.iconName)
                                        .foregroundColor(entry.swiftUIColor)
                                        .font(.title2)

                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(entry.date, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

                                        Text(entry.date, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.secondary)

                                        Text(entry.title)
                                            .font(.body)
                                            .foregroundColor(.primary)

                                        Text(entry.subtitle)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemBackground).opacity(0.6))
                                )
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 6)

                            // Séparateur entre les entrées (sauf après la dernière)
                            if entry.id != timeBanks.last?.id {
                                Divider()
                                    .padding(.horizontal, 12)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                }
                .applyAppFont(18)
                .frame(minWidth: 327)
                .background(Color(.secondarySystemBackground).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal, 16)

                Spacer()
            }
            .background(Color("deepBlue").opacity(0.05))
            .navigationTitle("Historique")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// ---------------------------------------------------------------
//  Preview
// ---------------------------------------------------------------
#Preview {
    // Container en mémoire uniquement pour la preview
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: TimeBankClass.self, configurations: config)

        // Quelques données factices pour la preview
        let now = Date()
        let sample = [
            TimeBankClass(
                userId: UserClass(logIn: "demo@email.fr", password: "", balance: 5),
                date: now,
                iconName: "hourglass.badge.plus",
                iconColor: .mintGreen,
                deposit: 3,
                withdrawal: 0,
                title: "Bienvenue sur Solid’Aide !",
                subtitle: "Solde de temps de bienvenue : +3h"
            ),
            TimeBankClass(
                userId: UserClass(logIn: "demo@email.fr", password: "", balance: 5),
                date: now.addingTimeInterval(-86400),
                iconName: "hourglass.tophalf.filled",
                iconColor: .warmCoral,
                deposit: 0,
                withdrawal: 1,
                title: "Demande de service",
                subtitle: "Solde de temps dépensé : -1h"
            )
        ]

        for item in sample { container.mainContext.insert(item) }
        try container.mainContext.save()

        return HistoricalTimeView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}
