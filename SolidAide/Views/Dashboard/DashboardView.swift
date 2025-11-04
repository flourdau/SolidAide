//
//  DashboardView.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    /*
     USER FICTIF
     */
//    @Query(filter: #Predicate<UserClass> { user in
//        user.logIn == "severine@email.fr"
//    }) var usersFound: [UserClass]
//    @State var userSession: UserSession


    @Environment(\.modelContext) private var context
//    @Environment(CurrentProfileModel.self) private var profileModel
    @Query(sort: \ProfileClass.pseudo) private var profiles: [ProfileClass]
//    @Query(sort: \TimeBankClass.updatedAt, order: .reverse) var timeBank: [TimeBankClass]
//    init() {}
//    private var currentProfile: ProfileClass? { profileModel.profile ?? profiles.first }
//    private var timeDeltaText: String {
//        let limit = Date().addingTimeInterval(-24*3600)
//        let deltaMinutes = timeBank
//            .filter { $0.updatedAt >= limit }
//            .reduce(0) { $0 + $1.deltaMinutes }
//        return "\(deltaMinutes.timeBankDisplay) depuis 24 heures"
//    }

//    private var totalText: String {
//        let total = timeBank.reduce(0) { $0 + $1.deltaMinutes }
//        return total.timeBankDisplay.replacingOccurrences(of: "+", with: "")
//    }

    var body: some View {
        ScrollView {
//            VStack(spacing: 16) {
//                Text("Tableau de bord")
//                    .font(.title2.weight(.semibold))
//
//                if let p = currentProfile {
//                    NavigationLink {
//                        ProfileDetailView(profile: p)
//                    } label: {
//                        ProfileCardView(profile: p)
//                    }
//                } else {
//                    RoundedRectangle(cornerRadius: 14)
//                        .fill(Color(.secondarySystemBackground))
//                        .overlay(Text("Créer mon profil").padding())
//                        .frame(height: 72)
//                }
//            }
//            .padding(.horizontal, 16)

            NavigationLink {
                TimeBankView()
            } label: {
                DashboardRow(
                    icon: "clock.badge.checkmark",
                    title: "Banque de temps",
                    //                    trailing: Text(timeDeltaText).foregroundStyle(.green)
                    trailing: Text("TEST").foregroundStyle(.green)

                )
            }

            NavigationLink { ServicesOffertsView() } label: {
                DashboardRow(icon: "hand.raised", title: "Services proposés")
            }

            NavigationLink { DemandesView() } label: {
                DashboardRow(icon: "hand.wave", title: "Demandes de service")
            }

            NavigationLink { NotificationsView() } label: {
                DashboardRow(icon: "bell", title: "Notifications")
            }

            NavigationLink { EvaluationsView() } label: {
                DashboardRow(icon: "star", title: "Evaluations")
            }

            NavigationLink { ParrainageView() } label: {
                DashboardRow(icon: "heart.text.square", title: "Parrainage", muted: true)
            }

            PrimaryCTAButton(title: "Demande d’aide", icon: "hand.raised.fill") {
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }
}

//extension Int {
//    var timeBankDisplay: String {
//        let sign = self >= 0 ? "+" : "−"
//        let m = abs(self), h = m / 60, mm = m % 60
//        return mm == 0 ? "\(sign)\(h)h" : "\(sign)\(h)h\(String(format: "%02d", mm))"
//    }
//}
//extension TimeBankClass {
//    var deltaHumanReadable: String {
//        minutes.timeBankDisplay
//    }
//}


#Preview {
    DashboardView()
}
