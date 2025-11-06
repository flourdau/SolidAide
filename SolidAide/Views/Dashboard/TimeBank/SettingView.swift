import SwiftUI

enum AppFont: String, CaseIterable, Identifiable {
    case system   = "System"
    case luciole  = "Luciole"
    case openDys  = "OpenDyslexic"

    var id: String { rawValue }
}

struct SettingsView: View {
//    @EnvironmentObject private var userSession: UserSession
    @AppStorage(kShowAdminTabKey) private var showAdminTab: Bool = false

    @AppStorage("selectedFont") private var selectedFontRaw = AppFont.system.rawValue
    @State private var tapCount = 0
    @State private var lastTapDate = Date()

    // -----------------------------------------------------------------
    // MARK: – Font binding
    // -----------------------------------------------------------------
    private var selectedFont: Binding<AppFont> {
        Binding<AppFont>(
            get: { AppFont(rawValue: selectedFontRaw) ?? .system },
            set: { newValue in selectedFontRaw = newValue.rawValue }
        )
    }

    // -----------------------------------------------------------------
    // MARK: – Secret tap (développeur)
    // -----------------------------------------------------------------
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

    // -----------------------------------------------------------------
    // MARK: – UI
    // -----------------------------------------------------------------
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // -------------------------------------------------
                    // 1️⃣  Sélecteur de police
                    // -------------------------------------------------
                    Section(header: Text("Police d’affichage")
                                .font(.headline)
                                .foregroundColor(.primary)) {
                        Picker("Choisissez votre police", selection: selectedFont) {
                            ForEach(AppFont.allCases) { font in
                                Text(font.rawValue).tag(font)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }

                    // -------------------------------------------------
                    // 2️⃣  Faux paramètres courants
                    // -------------------------------------------------
                    Section(header: Text("Paramètres généraux")
                                .font(.headline)
                                .foregroundColor(.primary)) {
                        VStack(alignment: .leading, spacing: 16) {
                            // Chaque ligne ressemble à une cellule de réglage
                            SettingRow(icon: "bell.fill", title: "Notifications")
                            SettingRow(icon: "lock.fill", title: "Sécurité")
                            SettingRow(icon: "globe", title: "Langue")
                            SettingRow(icon: "moon.fill", title: "Mode sombre")
                            SettingRow(icon: "person.crop.circle", title: "Compte")
                            SettingRow(icon: "cloud.fill", title: "Sauvegarde iCloud")
                            SettingRow(icon: "hand.tap.fill", title: "Gestes")
                            SettingRow(icon: "gearshape.2.fill", title: "Avancé")
                            // Ajoutez autant de lignes que vous le souhaitez pour forcer le scroll
//                            ForEach(0..<10) { _ in
//                                SettingRow(icon: "circle.grid.2x2.fill", title: "Option supplémentaire")
//                            }
                        }
                        .padding(.horizontal)
                    }

                    // -------------------------------------------------
                    // 3️⃣  Options Développeureuse (tout en bas)
                    // -------------------------------------------------
                    Section {
                        Button(action: secretTap) {
                            HStack {
                                Image(systemName: "hammer")
                                    .foregroundColor(.deepBlue)
                                Text("Options Développeureuse")
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 32)          // espace en haut et en bas du scroll
            }
            .navigationTitle("Paramètres")
            .applyAppFont(24)
            .fontWeight(.bold)
        }
        .applyAppFont(18)
    }
}

// -----------------------------------------------------------------
// MARK: – Ligne de réglage réutilisable
// -----------------------------------------------------------------
private struct SettingRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.deepBlue)
                .frame(width: 24, height: 24)

            Text(title)
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Ici vous pourriez naviguer vers la sous‑page correspondante.
        }
    }
}

// -----------------------------------------------------------------
// MARK: – Preview
// -----------------------------------------------------------------
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
//            .environmentObject(UserSession())
    }
}
