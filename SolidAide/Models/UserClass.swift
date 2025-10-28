//
//  UserClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

//@Model
class UserClass: Identifiable {
    var id = UUID()
    var logIn: String
    var password: String
    var timeBank: Int = 3
    var helper: [UserClass]? = nil
    var beneficiary: [UserClass]? = nil
    
    init(
        logIn: String,
        password: String,
        timeBank: Int,
        helper: [UserClass],
        beneficiary: [UserClass]
        
    ) {
        self.logIn = logIn
        self.password = password
        self.timeBank = timeBank
        self.helper = helper
        self.beneficiary = beneficiary
    }
    
}
