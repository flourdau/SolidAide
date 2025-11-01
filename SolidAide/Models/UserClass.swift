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
    @Relationship(inverse: \ProfileClass.userId)
    var profileId: ProfileClass?
    @Relationship(inverse: \TimeBankClass.userId)
    var timeBankId: [TimeBankClass]?
    var id = UUID()
    #Unique<UserClass>([\.logIn])
    var logIn: String
    var password: String
    var balance: Int

    init(
        logIn: String,
        password: String,
        balance: Int = 3
    ) {
        self.logIn = logIn
        self.password = password
        self.balance = balance
    }
    
}
