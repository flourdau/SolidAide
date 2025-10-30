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
    var timeBank: Int = 3

    init(
        logIn: String,
        password: String,
        timeBank: Int
    ) {
        self.logIn = logIn
        self.password = password
        self.timeBank = timeBank
    }
    
}
