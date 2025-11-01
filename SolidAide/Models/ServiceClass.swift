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
    var profilId: ProfileClass  // <== RENAMEME
    var profilIdHelper: ProfileClass? = nil // <== RENAMEME var + enum
    var skill: SkillsEnum
    var serviceDescription: String
    var city: String
    var isFree: Bool = false
    var timeSpent: Int
    var startDate: Date
    var serviceRepeat: ServiceRepeatEnum?
    var requestStatus: RequestStatusEnum// <== RENAMEME var + enum
    var isEvaluationCompleted: Bool = false
    var isFulfilled: Bool = false
    var serviceComment: String? = nil
    
    init(
        profilId: ProfileClass,// <== RENAMEME var + enum
        profilIdHelper: ProfileClass? = nil,// <== RENAMEME var + enum
        skill: SkillsEnum,
        serviceDescription: String,
        city: String,
        isFree: Bool,
        timeSpent: Int,
        startDate: Date,
        requestStatusRawValue: String? = nil,// <== RENAMEME var + enum
        serviceRepeat: ServiceRepeatEnum? = nil,
        requestStatus: RequestStatusEnum = .awaitingAcceptance,
        isEvaluationCompleted: Bool = false,
        isFulfilled: Bool = false,
        serviceComment: String? = nil
    ) {
        self.profilId = profilId// <== RENAMEME var + enum
        self.profilIdHelper = profilIdHelper// <== RENAMEME var + enum
        self.skill = skill
        self.serviceDescription = serviceDescription
        self.city = city
        self.isFree = isFree
        self.timeSpent = timeSpent
        self.startDate = startDate
        self.serviceRepeat = serviceRepeat
        self.requestStatus = requestStatus// <== RENAMEME var + enum
        self.isEvaluationCompleted = isEvaluationCompleted
        self.isFulfilled = isFulfilled
        self.serviceComment = serviceComment
    }
}
