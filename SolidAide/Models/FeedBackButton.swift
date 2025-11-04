
/*
  __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
|     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
                                       (|                      (|
*/
import SwiftUI
/*
 ____        _   _              _____      _   _
|  _ \      | | | |            |  __ \    | | | |
| |_) |_   _| |_| |_ ___  _ __ | |__) |_ _| |_| |_ ___ _ __ _ __
|  _ <| | | | __| __/ _ \| '_ \|  ___/ _` | __| __/ _ \ '__| '_ \
| |_) | |_| | |_| || (_) | | | | |  | (_| | |_| ||  __/ |  | | | |
|____/ \__,_|\__|\__\___/|_| |_|_|   \__,_|\__|\__\___|_|  |_| |_|
 */
struct TagButton: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    var isSelected: Bool = false
}
/*
 ____        _   _              _      _____  _____ _______
|  _ \      | | | |            | |    |_   _|/ ____|__   __|
| |_) |_   _| |_| |_ ___  _ __ | |      | | | (___    | |
|  _ <| | | | __| __/ _ \| '_ \| |      | |  \___ \   | |
| |_) | |_| | |_| || (_) | | | | |____ _| |_ ____) |  | |
|____/ \__,_|\__|\__\___/|_| |_|______|_____|_____/   |_|
 */
struct FeedBackButtonsView: View {

    private var qualities: [QualityEnum] {
        QualityEnum.allCases
    }
    @State private var tags: [TagButton] = []

    private let spacing: CGFloat = 4

    init() {
        let initialTags = qualities.map { quality in
            TagButton(title: quality.rawValue, icon: quality.icon)
        }
        _tags = State(initialValue: initialTags)
    }

    var body: some View {

/*
  _____                           _
 / ____|                         | |
| |  __  ___  ___  _ __ ___   ___| |_ _ __ _   _
| | |_ |/ _ \/ _ \| '_ ` _ \ / _ \ __| '__| | | |
| |__| |  __/ (_) | | | | | |  __/ |_| |  | |_| |
 \_____|\___|\___/|_| |_| |_|\___|\__|_|   \__, |
  _____                _                    __/ |
 |  __ \              | |                  |___/
 | |__) |___  __ _  __| | ___ _ __
 |  _  // _ \/ _` |/ _` |/ _ \ '__|
 | | \ \  __/ (_| | (_| |  __/ |
 |_|  \_\___|\__,_|\__,_|\___|_|
*/

GeometryReader { geo in
            let maxWidth = geo.size.width - 12
            let rows = arrange(tags: tags, maxWidth: maxWidth, spacing: spacing)
/*
 _____  _           _
|  __ \(_)         | |
| |  | |_ ___ _ __ | | __ _ _   _
| |  | | / __| '_ \| |/ _` | | | |
| |__| | \__ \ |_) | | (_| | |_| |
|_____/|_|___/ .__/|_|\__,_|\__, |
             | |             __/ |
             |_|            |___/

*/
            VStack(alignment: .center, spacing: spacing) {
                ForEach(0..<rows.count, id: \.self) { rowIndex in
                    HStack(spacing: spacing) {
                        ForEach(rows[rowIndex]) { tag in
                            Button(action: {
                                if let idx = tags.firstIndex(where: { $0.id == tag.id }) {
                                    tags[idx].isSelected.toggle()
                                }
                            }) {
                                HStack{
                                    Image(systemName: (tag.icon))
                                    Text(tag.title)
                                        .lucioleRegular(fontSize: 14)
                                        .layoutPriority(1)
                                        .lineLimit(1)
                                        .minimumScaleFactor(1)
                                }
                                .foregroundColor(tag.isSelected ? Color.black : Color.white)
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
            .frame(maxWidth: .infinity, alignment: .center)               .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(.systemBackground))
    }

/*
 __          __
 \ \        / /
  \ \  /\  / / __ __ _ _ __
   \ \/  \/ / '__/ _` | '_ \
    \  /\  /| | | (_| | |_) |
     \/  \/ |_|  \__,_| .__/
                      | |
                      |_|
 */
    private func arrange(tags: [TagButton],
                         maxWidth: CGFloat,
                         spacing: CGFloat) -> [[TagButton]] {

        var rows: [[TagButton]] = [[]]
        var currentRowWidth: CGFloat = 0
        let iconWidth: CGFloat = 16
        let extraPadding: CGFloat = 32

        for tag in tags {
            let _ = UILabel()
            let label = UILabel()
            label.text = tag.title
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.sizeToFit()
            let textWidth = label.frame.width
            

            let buttonWidth = textWidth + iconWidth + extraPadding

            let projectedWidth = currentRowWidth == 0 ?
                                 buttonWidth :
                                 currentRowWidth + spacing + buttonWidth

            if projectedWidth > maxWidth {
                rows.append([tag])
                currentRowWidth = buttonWidth
            } else {
                rows[rows.count - 1].append(tag)
                currentRowWidth = projectedWidth
            }
        }
        return rows
    }
}

    /*
     _____                _
    |  __ \              (_)
    | |__) | __ _____   ___  _____      __
    |  ___/ '__/ _ \ \ / / |/ _ \ \ /\ / /
    | |   | | |  __/\ V /| |  __/\ V  V /
    |_|   |_|  \___| \_/ |_|\___| \_/\_/
     */
#Preview {
    FeedBackButtonsView()
}
