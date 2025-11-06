import Foundation
import SwiftUI
import SwiftData
import Observation

@Observable
final class ServiceFormViewModel {
    // MARK: - Données du formulaire
    var profileId: ProfileClass?
    var skill: SkillsEnum = .digital
    var serviceDescription: String = ""
    var city: String = ""
    var isFree: Bool = false
    var timeSpent: Int = 1
    var startDate: Date = Date()
    var serviceRepeat: ServiceRepeatEnum? = nil
    var userSession: UserClass?

    // MARK: - Logique interne
    var isEditing: Bool
    private var serviceToEdit: ServiceClass?

    // MARK: - Initialisateurs
    init(userSession: UserClass?) {
        self.isEditing = false
        self.userSession = userSession
        self.profileId = userSession?.profileId
    }

    init(service: ServiceClass) {
        self.isEditing = true
        self.serviceToEdit = service

        self.profileId = service.profileId
        self.skill = service.skill
        self.serviceDescription = service.serviceDescription
        self.city = service.city
        self.isFree = service.isFree
        self.timeSpent = service.timeSpent
        self.startDate = service.startDate
        self.serviceRepeat = service.serviceRepeat
    }

    // MARK: - Validation
    var canSave: Bool {
        guard let _ = profileId else { return false }
        return !city.trimmingCharacters(in: .whitespaces).isEmpty &&
               timeSpent > 0 &&
               !serviceDescription.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Persistance
    func save(context: ModelContext) {
        guard canSave, let profile = profileId else { return }

        if isEditing {
            guard let service = serviceToEdit else { return }
            service.profileId = profile
            service.skill = skill
            service.serviceDescription = serviceDescription
            service.city = city
            service.isFree = isFree
            service.timeSpent = timeSpent
            service.startDate = startDate
            service.serviceRepeat = serviceRepeat
        } else {
            let newService = ServiceClass(
                profileId: profile,
                skill: skill,
                serviceDescription: serviceDescription,
                city: city,
                isFree: isFree,
                timeSpent: timeSpent,
                startDate: startDate,
                serviceRepeat: serviceRepeat
            )

            if let user = userSession {
                user.balance = (user.balance) - timeSpent
            }

            context.insert(newService)

            do {
                try context.save()
            } catch {
                print("❗️ Erreur lors de la sauvegarde du service : \(error)")
            }
        }
    }
}
