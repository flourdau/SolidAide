//
//  UserClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import Foundation
import SwiftData

@Model
class UserClass: Identifiable {
    var id = UUID()
    var logIn: String
    var password: String
    var balance: Int = 0
    var timeBank: Int = 3

    @Relationship(inverse: \ProfileClass.userId)
    var profileId: ProfileClass?

    init(
        logIn: String,
        password: String,
        balance: Int,
        timeBank: Int
    ) {
        self.logIn = logIn
        self.password = password
        self.balance = balance
        self.timeBank = timeBank
    }
    
}
