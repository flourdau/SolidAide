//
//  ServiceClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import Foundation
import SwiftData

@Model
class ServiceClass: Identifiable {
    var id = UUID()
    var profileId: ProfileClass
    var profileIdHelper: ProfileClass? = nil
    var skill: SkillsEnum
    var serviceDescription: String
    var city: String
    var isFree: Bool = false
    var timeSpent: Int
    var startDate: Date
    var serviceRepeat: ServiceRepeatEnum?
    var serviceStatus: ServiceStatusEnum
    var isEvaluationCompleted: Bool = false
    var isFulfilled: Bool = false
    var serviceComment: String? = nil
    
    init(
        profileId: ProfileClass,
        profileIdHelper: ProfileClass? = nil,
        skill: SkillsEnum,
        serviceDescription: String,
        city: String,
        isFree: Bool,
        timeSpent: Int,
        startDate: Date,
        serviceRepeat: ServiceRepeatEnum? = nil,
        serviceStatus: ServiceStatusEnum = .awaitingAcceptance,
        isEvaluationCompleted: Bool = false,
        isFulfilled: Bool = false,
        serviceComment: String? = nil
    ) {
        self.profileId = profileId
        self.profileIdHelper = profileIdHelper
        self.skill = skill
        self.serviceDescription = serviceDescription
        self.city = city
        self.isFree = isFree
        self.timeSpent = timeSpent
        self.startDate = startDate
        self.serviceRepeat = serviceRepeat
        self.serviceStatus = serviceStatus
        self.isEvaluationCompleted = isEvaluationCompleted
        self.isFulfilled = isFulfilled
        self.serviceComment = serviceComment
    }
}
