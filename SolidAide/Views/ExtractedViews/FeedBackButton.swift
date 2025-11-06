import SwiftUI
import UIKit          // ← nécessaire pour UILabel (mesure du texte)

/*=====================================================================
  TagButton – représente un bouton « qualité » affiché dans le
  composant FeedBackButtonsView.
=====================================================================*/
struct TagButton: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    var isSelected: Bool = false
}

/*=====================================================================
  FeedBackButtonsView – grille dynamique de TagButton
=====================================================================*/
struct FeedBackButtonsView: View {

    // -----------------------------------------------------------------
    // 1️⃣  Toutes les qualités disponibles (définies dans QualityEnum)
    // -----------------------------------------------------------------
    private var qualities: [QualityEnum] {
        QualityEnum.allCases
    }

    // -----------------------------------------------------------------
    // 2️⃣  Etat interne des tags (sélection / désélection)
    // -----------------------------------------------------------------
    @State private var tags: [TagButton] = []

    // -----------------------------------------------------------------
    // 3️⃣  Paramètres d’espacement
    // -----------------------------------------------------------------
    private let spacing: CGFloat = 4

    // -----------------------------------------------------------------
    // 4️⃣  Initialisation des tags à partir des qualités
    // -----------------------------------------------------------------
    init() {
        let initialTags = qualities.map { quality in
            TagButton(title: quality.rawValue, icon: quality.icon)
        }
        _tags = State(initialValue: initialTags)
    }

    // -----------------------------------------------------------------
    // 5️⃣  Corps de la vue
    // -----------------------------------------------------------------
    var body: some View {
        GeometryReader { geo in
            let maxWidth = geo.size.width - 12                // marge intérieure
            let rows = arrange(tags: tags,
                               maxWidth: maxWidth,
                               spacing: spacing)

            VStack(alignment: .center, spacing: spacing) {
                ForEach(0..<rows.count, id: \.self) { rowIndex in
                    HStack(spacing: spacing) {
                        ForEach(rows[rowIndex]) { tag in
                            Button(action: {
                                if let idx = tags.firstIndex(where: { $0.id == tag.id }) {
                                    tags[idx].isSelected.toggle()
                                }
                            }) {
                                HStack {
                                    Image(systemName: tag.icon)
                                    Text(tag.title)
                                        .lucioleRegular(fontSize: 14)
                                        .layoutPriority(1)
                                        .lineLimit(1)
                                        .minimumScaleFactor(1)
                                }
                                .foregroundColor(tag.isSelected ? .black : .white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(tag.isSelected ? Color.goldenYellow : Color.deepBlue)
                                .cornerRadius(15)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(.systemBackground))
    }

    // -----------------------------------------------------------------
    // 6️⃣  Calcul des lignes en fonction de la largeur disponible
    // -----------------------------------------------------------------
    private func arrange(tags: [TagButton],
                         maxWidth: CGFloat,
                         spacing: CGFloat) -> [[TagButton]] {

        var rows: [[TagButton]] = [[]]
        var currentRowWidth: CGFloat = 0
        let iconWidth: CGFloat = 16          // largeur approximative de l’icône SF
        let extraPadding: CGFloat = 32      // padding horizontal du bouton

        for tag in tags {
            // Mesure du texte avec UILabel (UIKit) – fonctionne sur iOS
            let label = UILabel()
            label.text = tag.title
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.sizeToFit()
            let textWidth = label.frame.width

            let buttonWidth = textWidth + iconWidth + extraPadding
            let projectedWidth = currentRowWidth == 0
                ? buttonWidth
                : currentRowWidth + spacing + buttonWidth

            if projectedWidth > maxWidth {
                // Nouvelle ligne
                rows.append([tag])
                currentRowWidth = buttonWidth
            } else {
                // Ajout à la ligne courante
                rows[rows.count - 1].append(tag)
                currentRowWidth = projectedWidth
            }
        }
        return rows
    }
}

/*=====================================================================
  Preview
=====================================================================*/
#Preview {
    FeedBackButtonsView()
}
