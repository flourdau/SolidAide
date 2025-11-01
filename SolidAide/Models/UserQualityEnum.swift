//
//  UserQualityEnum.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

enum UserQualityEnum: String, CaseIterable, Codable {
    case reliableNeighbour = "Voisin fiable"
    case punctual = "Ponctuel"
    case available = "Disponible"
    case patient = "Patient"
    case goodCommunication = "Bonne Communication"
    case activeMember = "Membre actif"
    case efficient = "Efficace"
    case verySupportive = "Très solidaire"

    var emoji: String {
        switch self {
        case .reliableNeighbour: return "figure.wave "
        case .punctual: return "clock.fill"
        case .available: return "star.fill"
        case .patient: return "figure.mind.and.body"
        case .goodCommunication: return "person.line.dotted.person.fill"
        case .activeMember: return "figure.run"
        case .efficient: return "bolt.fill"
        case .verySupportive: return "figure.2.right.holdinghands"
        }
    }
}
