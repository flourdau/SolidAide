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
    var profilId: ProfileClass
    var profilIdHelper: ProfileClass? = nil
    @Attribute private var skillRawValue: String
    var skill: SkillsEnum {
        get {
            guard let skill = SkillsEnum(rawValue: skillRawValue) else {
                fatalError("Erreur fatale : skillsRawValue corrompue")
            }
            return skill
        }
        
        set { skillRawValue = newValue.rawValue }
        
    }
    var serviceDescription: String
    var city: String
    var position: GPSCoordinateStruct? = nil
    var isFree: Bool = false
    var timeSpent: Int
    var startDate: Date
    @Attribute private var serviceRepeatRawValue: String? = nil
    var serviceRepeat: ServiceRepeatEnum? {
        get {
            guard let rawValue = serviceRepeatRawValue else { return nil }
            return ServiceRepeatEnum(rawValue: rawValue)
        }
        
        set {
            serviceRepeatRawValue = newValue?.rawValue
        }
        
    }
    @Attribute private var requestStatusRawValue: String
    var requestStatus: RequestStatusEnum {
        get {
            return RequestStatusEnum(rawValue: requestStatusRawValue) ?? .awaitingAcceptance
        }
        
        set {
            requestStatusRawValue = newValue.rawValue
        }
        
    }
    var isEvaluationCompleted: Bool = false
    var isFulfilled: Bool = false
    var serviceComment: String? = nil
    
    init(
        profilId: ProfileClass,
        profilIdHelper: ProfileClass? = nil,
        skill: SkillsEnum,
        serviceDescription: String,
        city: String,
        position: GPSCoordinateStruct? = nil,
        isFree: Bool,
        timeSpent: Int,
        startDate: Date,
        requestStatusRawValue: String? = nil,
        serviceRepeat: ServiceRepeatEnum? = nil,
        requestStatus: RequestStatusEnum = .awaitingAcceptance,
        isEvaluationCompleted: Bool = false,
        isFulfilled: Bool = false,
        serviceComment: String? = nil
    ) {
        self.profilId = profilId
        self.profilIdHelper = profilIdHelper
        self.skillRawValue = skill.rawValue
        self.serviceDescription = serviceDescription
        self.city = city
        self.position = position
        self.isFree = isFree
        self.timeSpent = timeSpent
        self.startDate = startDate
        self.serviceRepeatRawValue = serviceRepeat?.rawValue
        self.requestStatusRawValue = requestStatus.rawValue
        self.isEvaluationCompleted = isEvaluationCompleted
        self.isFulfilled = isFulfilled
        self.serviceComment = serviceComment
    }
}
