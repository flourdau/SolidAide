//
//  RequestStatusEnum.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

enum RequestStatusEnum : String, CaseIterable {
    case awaitingAcceptance = "En attente d’acceptation"
    case approved = "Acceptée"
    case executed = "Effectuée"
    case awaitingEvaluation = "En attente d’évaluation"
    case finalized = "Finalisée"
}
