//
//  ServiceFormViewModel.swift
//  SolidAide
//
//  Created by apprenant78 on 02/11/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class ServiceFormViewModel {
    /// État du Formulaire --
    var profileId: ProfileClass?
    var skill: SkillsEnum = .digital
    var serviceDescription: String = ""
    var city: String = ""
    var isFree: Bool = false
    var timeSpent: Int = 1
    var startDate: Date = Date()
    var serviceRepeat: ServiceRepeatEnum? = nil
    
    /// État de la Logique ---
    var isEditing: Bool
    private var serviceToEdit: ServiceClass?
    
    /// Initialiseur pour (C)REATE (un nouveau service)
    init() {
        self.isEditing = false
        
    }
    
    /// Initialiseur pour (U)PDATE (un service existant)
    init(service: ServiceClass) {
        self.isEditing = true
        self.serviceToEdit = service
        
        /// Pré-remplir le formulaire avec les données du service
        self.profileId = service.profileId
        self.skill = service.skill
        self.serviceDescription = service.serviceDescription
        self.city = service.city
        self.isFree = service.isFree
        self.timeSpent = service.timeSpent
        self.startDate = service.startDate
        self.serviceRepeat = service.serviceRepeat
    }
    
    /// Logique de validation simple
    var canSave: Bool {
        // Un service doit avoir un demandeur (profileId)
        // et une description non vide.
        // UN SKILL!!!
        // Une ville
        // Un timeSpent
        // Une Date
        // Assez de temps dans le porte monnaie sauf si free....
//        return skill.rawValue.count > 0 &&
        return !city.trimmingCharacters(in: .whitespaces).isEmpty &&
        timeSpent > 0 &&
        //        startDate != nil &&
        !serviceDescription.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    /// Action d'edit (Create & Update)
    func save(context: ModelContext) {
        /// Validation
        guard canSave, let profileId = profileId else {
            print("Erreur: Impossible de sauvegarder, données manquantes.")
            return
        }
        
        if isEditing {
            /// (U)PDATE
            guard let service = serviceToEdit else { return }
            service.profileId = profileId
            service.skill = skill
            service.serviceDescription = serviceDescription
            service.city = city
            service.isFree = isFree
            service.timeSpent = timeSpent
            service.startDate = startDate
            service.serviceRepeat = serviceRepeat
            
        }
        else {
            /// (C)REATE
            let newService = ServiceClass(
                profileId: profileId,
                skill: skill,
                serviceDescription: serviceDescription,
                city: city,
                isFree: isFree,
                timeSpent: timeSpent,
                startDate: startDate,
                serviceRepeat: serviceRepeat

            )
            context.insert(newService)
        }
        
    }
}
