//
//  RequestStatusEnum.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

enum RequestStatusEnum : String, CaseIterable, Codable {
    case awaitingAcceptance = "En attente d’acceptation"
    case approved = "Acceptée"
    case executed = "Effectuée"
    case awaitingEvaluation = "En attente d’évaluation"
    case finalized = "Finalisée"

    var sfSymbol: String {
        switch self {
        case .awaitingAcceptance: return "clock"
        case .approved: return "checkmark.circle.fill"
        case .executed: return "briefcase.fill"
        case .awaitingEvaluation: return "text.badge.checkmark"
        case .finalized: return "flag.checkered"
        }
    }
}
