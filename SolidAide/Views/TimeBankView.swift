
/*


   ____     ___    ___  ___   _    __
  / __/__  / (_)__/ ( )/ _ | (_)__/ /__
 _\ \/ _ \/ / / _  /|// __ |/ / _  / -_)
/___/\___/_/_/\_,_/  /_/ |_/_/\_,_/\__/
                                      




  O          o
 / \         |
o---oo-o   o-O o-o o-o o  o
|   ||  | |  | |   |-' |  |
o   oo  o  o-o o   o-o o--O
                          |
                       o--o
o--o    o   o
|       | o |
O-o   o-O   | o-o o-o  o-o
|    |  | | | |-' |  | |-'
o--o  o-o | o o-o o  o o-o


o--o o
|    |         o
O-o  | o-o o-o    oo o-o
|    | | | |   | | | |  |
o    o o-o o   | o-o-o  o


 o-o
|                   o
 o-o  o   o o-o o-o   o-o  o-o
    |  \ /  |-' |   | |  | |-'
o--o    o   o-o o   | o  o o-o

 o-o   o
|      |
 o-o  -o-  oo  o-o o  o
    |  |  | | |    |  |
o--o   o  o-o- o-o o--O
                      |
                   o--o





*/


import SwiftUI
import Charts
import SwiftData

struct TimeBankView: View {

    
    @Environment(\.modelContext) private var context
    @Query var users: [UserClass]
    @Query var profiles: [ProfileClass]
    @Query var chats: [ChatClass]
    @Query var services: [ServiceClass]
    @Query var timeBanks: [TimeBankClass]
    
    // ── Données du graphique ────────────────────────
    @State private var timeValues: [Int] = [
        3, 2, 5, 7, 6, 5, 4, 3, 5, 7, 6, 5, 4, 3, 5
    ]

    // ── Journal des transactions ─────────────────────
   // @State private var entries: [TimeBankClass] = TimeBankClass.sampleEntries
    
    //_______ DataFake provisional (to be commented on in the near future)
//    var entries: [TimeBankClass] {
//        [
//            //__________________________à extraire. Vu avec Flo.
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 12, minute: 25).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .deepBlue,
//            title: "Bienvenue sur Solid’Aide !",
//            subtitle: "Solde de temps de bienvenue : +\(timeValues[0])h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à () pour du ().",
//            subtitle: "Solde de temps dépensé : \(timeValues[1]-(timeValues[0]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .mintGreen,
//            title: "Proposition de service à () pour du ().",
//            subtitle: "Solde de temps gagné : +\(timeValues[2]-(timeValues[1]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .mintGreen,
//            title: "Proposition de service à Ghania pour bricoler.",
//            subtitle: "Solde de temps gagné : +\(timeValues[3]-(timeValues[2]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[4]-(timeValues[3]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[5]-(timeValues[4]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[6]-(timeValues[5]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[7]-(timeValues[6]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .mintGreen,
//            title: "Proposition de service à Ghania pour bricoler.",
//            subtitle: "Solde de temps gagné : +\(timeValues[8]-(timeValues[7]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .mintGreen,
//            title: "Proposition de service à Ghania pour bricoler.",
//            subtitle: "Solde de temps gagné : +\(timeValues[9]-(timeValues[8]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[10]-(timeValues[9]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[11]-(timeValues[10]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[12]-(timeValues[11]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
//            iconName: "hourglass.tophalf.filled",
//            iconColor: .warmCoral,
//            title: "Demande de service à Angela pour passer la tondeuse.",
//            subtitle: "Solde de temps dépensé : \(timeValues[13]-(timeValues[12]))h"
//        ),
//        TimeBankClass(
//            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
//            iconName: "hourglass.badge.plus",
//            iconColor: .mintGreen,
//            title: "Proposition de service à Ghania pour bricoler.",
//            subtitle: "Solde de temps gagné : +\(timeValues[14]-(timeValues[13]))h")
//    ]}
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
                //___________ Navigation to "SettingView" & "HistoricalTimeView"
                HStack{
                    NavigationLink {
                        HistoricalTimeView()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color("deepBlue"))
                                .cornerRadius(15)
                                .frame(width: 130, height: 30)
                            HStack{
                                Image(systemName: "hourglass.badge.eye")
                                    .foregroundStyle(Color.white)
                                Text("Historique")
                                    .foregroundStyle(Color.white)
                                    .lucioleRegular(fontSize: 16)
                            }
                        }
                    }
                    NavigationLink {
                        SettingView()
                    } label: {
                        
                    
                        Spacer()
                        ZStack{
                            Rectangle()
                                .fill(Color("deepBlue"))
                                .cornerRadius(15)
                                .frame(width: 130, height: 30)
                            HStack{
                                Image(systemName: "gearshape.fill")
                                    .foregroundStyle(Color.white)
                                Text("Paramètres")
                                    .foregroundStyle(Color.white)
                                    .lucioleRegular(fontSize: 16)
                               }
                            }
                        }
                }
                
                
                // ---------- En‑tête ----------
                ZStack {
                    Rectangle()
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color("mintGreen"))
                    Text("Banque du Temps")
                        .foregroundStyle(.white)
                        .lucioleRegular(fontSize: 20)
                }
                .padding()
                
                // ---------- Graphique ----------
                Chart {
                    ForEach(Array(timeValues.enumerated()), id: \.offset) { index, value in
                        LineMark(
                            x: .value("Index", index),
                            y: .value("Valeur", value)
                        )
                        .foregroundStyle(Color("goldenYellow"))
                        
                        PointMark(
                            x: .value("Index", index),
                            y: .value("Valeur", value)
                        )
                        .foregroundStyle(Color("goldenYellow"))
                        .symbolSize(30)
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(width: 327, height: 100)
                .background(Color("deepBlue"))
                .padding(.top, 8)
                
                // ---------- Liste scrollable ----------
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        // spacing = 0 → on gère les espaces avec Divider + padding
                        ForEach(timeBanks) { entry in
                            VStack(alignment: .leading, spacing: 6) {
                                // ---- Icône + texte ----
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: entry.iconName)
                                        .foregroundColor(entry.swiftUIColor)
                                        .font(.title2)
                                    VStack(alignment: .leading, spacing: 1) {
                                        // Date + heure
                                        Text(entry.date, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        Text(entry.date, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        // Titre principal
                                        Text(entry.title)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        // Sous‑titre (solde, description…)
                                        Text(entry.subtitle)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)          // espace interne vertical
                                .padding(.horizontal, 12)       // espace interne horizontal
                                .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemBackground).opacity(0.6))
                                )
                            }
                            .padding(.horizontal, 4)            // petit espace latéral entre blocs
                            .padding(.vertical, 6)
                            // Séparateur visuel
                            if entry.id != timeBanks.last?.id {    // pas de trait après le dernier
                                Divider()
                                    .padding(.horizontal, 12)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                }
                .frame(minWidth: 327)
                .background(Color(.secondarySystemBackground).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                Spacer()
            }
            .background(Color("deepBlue").opacity(0.05))
        } // légère nuance de fond
    }

    // ── Fonctions d’aide au graphique (inchangées) ──
    private func popFirstAndAppend(_ newValue: Int) {
        if !timeValues.isEmpty {
            timeValues.removeFirst()
        }
        timeValues.append(newValue)
    }
}

// ------------------------------------------------------------
// MARK: – Preview
// ------------------------------------------------------------
struct TimeBankView_Previews: PreviewProvider {
    static var previews: some View {
        TimeBankView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
