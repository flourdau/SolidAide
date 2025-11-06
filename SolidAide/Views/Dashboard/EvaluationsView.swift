import SwiftUI

// ---------------------------------------------------------------
//  EvaluationsView – affiche 4 qualités aléatoires sur fond doré
// ---------------------------------------------------------------
struct EvaluationsView: View {
    // -----------------------------------------------------------
    // 1️⃣  Qualités disponibles (enum QualityEnum déjà présent dans le projet)
    // -----------------------------------------------------------
    private var randomQualities: [QualityEnum] {
        // Mélange les qualités et garde les 4 premières
        Array(QualityEnum.allCases.shuffled().prefix(4))
    }

    // -----------------------------------------------------------
    // 2️⃣  Corps de la vue
    // -----------------------------------------------------------
    var body: some View {
        VStack(spacing: 24) {
            // -------------------------------------------------------
            // Titre
            // -------------------------------------------------------
            Text("Vos évaluations")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)

            // -------------------------------------------------------
            // Grille de 4 qualités (affichées comme des « chips »)
            // -------------------------------------------------------
            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible())],
                      spacing: 16) {
                ForEach(randomQualities, id: \.self) { quality in
                    HStack(spacing: 8) {
                        Image(systemName: quality.icon)
                            .foregroundStyle(.white)
                        Text(quality.rawValue)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.goldenYellow)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .padding(.top, 32)
        .navigationTitle("Évaluations")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

// ---------------------------------------------------------------
//  Preview
// ---------------------------------------------------------------
#Preview {
    NavigationStack {
        EvaluationsView()
    }
}
