import Foundation
import SwiftData

@Model
class UserClass: Identifiable {
    @Relationship(inverse: \ProfileClass.userId)
    var profileId: ProfileClass?
    
    @Relationship(inverse: \TimeBankClass.userId)
    var timeBankId: [TimeBankClass]?

    var id = UUID()
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
