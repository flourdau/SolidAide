//
//  serviceRepeatEnum.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

enum ServiceRepeatEnum : String, CaseIterable {
    case everyDay = "Tous les jours"
    case everyWeek = "Toutes les semaines"
    
    var durationInHours: Int {
        switch self {
        case .everyDay:
            return 24
        case .everyWeek:
            return 24 * 7
        }
    }
    
    var durationInDays: Int {
        switch self {
        case .everyDay:
            return 1
        case .everyWeek:
            return 7
        }
    }
    
}
