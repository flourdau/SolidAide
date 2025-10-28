//
//  ServiceClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import Foundation
import SwiftData

//@Model
class ServiceClass: Identifiable {
    var profilId: ProfileClass? = nil
    var skills: SkillsEnum
    var description: String
    var position: GPSCoordinateStruct
    var isFree: Bool = false
    var timeSpent: Int
    var startDate: Date
    var serviceRepeat: ServiceRepeatEnum? = nil
    var requestStatus: RequestStatusEnum = .awaitingAcceptance
    var isEvaluationCompleted: Bool = false
    var isFulfilled: Bool = false
    var serviceComment: String? = nil

    init(
        profilId: ProfileClass? = nil,
        skills: SkillsEnum,
        description: String,
        position: GPSCoordinateStruct,
        isFree: Bool,
        timeSpent: Int,
        startDate: Date,
        serviceRepeat: ServiceRepeatEnum,
        requestStatus: RequestStatusEnum,
        isEvaluationCompleted: Bool,
        isFulfilled: Bool,
        serviceComment: String)
    {
        self.profilId = profilId
        self.skills = skills
        self.description = description
        self.position = position
        self.isFree = isFree
        self.timeSpent = timeSpent
        self.startDate = startDate
        self.serviceRepeat = serviceRepeat
        self.requestStatus = requestStatus
        self.isEvaluationCompleted = isEvaluationCompleted
        self.isFulfilled = isFulfilled
        self.serviceComment = serviceComment
    }
}
