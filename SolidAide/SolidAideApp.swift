import SwiftUI
import SwiftData

@main
struct SolidAideApp: App {
    @StateObject private var userSession = UserSession()
    @State private var container: ModelContainer
    @State private var showSplash = true
    
    init() {
        let cfg = ModelConfiguration()
        let createdContainer: ModelContainer
        do {
            createdContainer = try ModelContainer(
                for: UserClass.self,
                ProfileClass.self,
                ChatClass.self,
                ServiceClass.self,
                TimeBankClass.self,
                configurations: cfg
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }

        let descriptor = FetchDescriptor<UserClass>()
        if (try? createdContainer.mainContext.fetch(descriptor).isEmpty) ?? true {
            GenerateDataBaseFunc(context: createdContainer.mainContext)
        }

        UserDefaults.standard.set("severine@email.fr", forKey: "loggedInEmail")
        _container = State(initialValue: createdContainer)
    }

    var body: some Scene {
        WindowGroup {
            if showSplash {
                            SplashScreen()
                                .onAppear {
                                    // Après 2 secondes on passe à l’app principale
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        withAnimation(.easeOut) {
                                            showSplash = false
                                        }
                                    }
                                }
            } else {
                SolidAideView()
                    .environmentObject(userSession)
                    .modelContainer(container)
            }
        }
    }
}
