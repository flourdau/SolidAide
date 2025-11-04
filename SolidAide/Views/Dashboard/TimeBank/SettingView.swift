/*
  __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
|     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
                                       (|                      (|
*/
import SwiftUI
import SwiftData


enum AppFont: String, CaseIterable, Identifiable {
    case system   = "System"
    case luciole  = "Luciole"
    case openDys  = "OpenDyslexic"

    var id: String { rawValue }
}


struct SettingsView: View {
    @AppStorage(kShowAdminTabKey) private var showAdminTab: Bool = false

    func logout() {
        showAdminTab = false
    }
    @AppStorage("selectedFont") private var selectedFontRaw = AppFont.system.rawValue
    @State private var tapCount = 0
    @State private var lastTapDate = Date()

    /*
                      ______          _
    /\               |  ____|        | |
   /  \   _ __  _ __ | |__ ___  _ __ | |_
  / /\ \ | '_ \| '_ \|  __/ _ \| '_ \| __|
 / ____ \| |_) | |_) | | | (_) | | | | |_
/_/    \_\ .__/| .__/|_|  \___/|_| |_|\__|
         | |   | |
         |_|   |_|
     */
    
    private var selectedFont: Binding<AppFont> {
        Binding<AppFont>(
             get: { AppFont(rawValue: selectedFontRaw) ?? .system },
             set: { newValue in selectedFontRaw = newValue.rawValue }
         )
    }
    /*
                        _ _______
                       | |__   __|
 ___  ___  ___ _ __ ___| |_ | | __ _ _ __
/ __|/ _ \/ __| '__/ _ \ __|| |/ _` | '_ \
\__ \  __/ (__| | |  __/ |_ | | (_| | |_) |
|___/\___|\___|_|  \___|\__||_|\__,_| .__/
                                    | |
                                    |_|
     */
       private func secretTap() {
           let now = Date()
           if now.timeIntervalSince(lastTapDate) > 2.0 {
               tapCount = 0
           }
           tapCount += 1
           lastTapDate = now
           if tapCount >= 5 {
                       withAnimation {
                           showAdminTab = true
                       }
                       tapCount = 0
                   }
               }
    
    /*
     ____            _        __      ___
    |  _ \          | |       \ \    / (_)                _
    | |_) | ___   __| |_   _   \ \  / / _  _____      __ (_)
    |  _ < / _ \ / _` | | | |   \ \/ / | |/ _ \ \ /\ / /
    | |_) | (_) | (_| | |_| |    \  /  | |  __/\ V  V /   _
    |____/ \___/ \__,_|\__, |     \/   |_|\___| \_/\_/   (_)
                        __/ |
                       |___/
     */
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Police d’affichage")) {
/*
 ______          _   _____ _      _
|  ____|        | | |  __ (_)    | |
| |__ ___  _ __ | |_| |__) |  ___| | _____ _ __
|  __/ _ \| '_ \| __|  ___/ |/ __| |/ / _ \ '__|
| | | (_) | | | | |_| |   | | (__|   <  __/ |
|_|  \___/|_| |_|\__|_|   |_|\___|_|\_\___|_|
                                                
                                                
 */
                    Picker("Choisissez votre police", selection: selectedFont) {
                        ForEach(AppFont.allCases) { font in
                            Text(font.rawValue).tag(font)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
/*
     _                             _           _    _______    _
    | |                   /\      | |         (_)  |__   __|  | |
 ___| |__   _____      __/  \   __| |_ __ ___  _ _ __ | | __ _| |__
/ __| '_ \ / _ \ \ /\ / / /\ \ / _` | '_ ` _ \| | '_ \| |/ _` | '_ \
\__ \ | | | (_) \ V  V / ____ \ (_| | | | | | | | | | | | (_| | |_) |
|___/_| |_|\___/ \_/\_/_/    \_\__,_|_| |_| |_|_|_| |_|_|\__,_|_.__/
                                                                 
                                                                 
 */
                Section {
                                    Button(action: {
                                        secretTap()
                                    }) {
                                        HStack {
                                            Image(systemName: "hammer")
                                            Text("Options Développeureuse")
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .foregroundColor(.deepBlue)          // couleur “action”
                                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            .applyAppFont(18)
            
           
            .navigationTitle("Paramètres")
            .applyAppFont(24)
            .fontWeight(.bold)
            
        }
        .applyAppFont(18)
        .fontWeight(.bold)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
