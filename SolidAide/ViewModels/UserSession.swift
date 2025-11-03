//
//  UserSession.swift
//  SolidAide
//
//  Created by apprenant78 on 03/11/2025.
//

import SwiftUI

@Observable
final class UserSession {
    var currentUser: UserClass?

    init(user: UserClass? = nil) {
        self.currentUser = user
    }
}
