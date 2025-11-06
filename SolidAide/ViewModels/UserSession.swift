import Foundation
import Combine
import SwiftUI

final class UserSession: ObservableObject {
    @Published var currentUser: UserClass? = nil
}
