/*
  __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
|     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
                                       (|                      (|
*/
import SwiftUI

struct SkillSelector: View {
    @Binding var selected: Set<SkillsEnum>
    var editable: Bool = false
    var showOnlySelected: Bool = false

    private var allSkills: [SkillsEnum] { SkillsEnum.allCases }

    private var skillsToShow: [SkillsEnum] {
        if editable || !showOnlySelected {
            return allSkills
        } else {
            return Array(selected)
        }
    }

    var body: some View {
        GeometryReader { geo in
            let maxWidth = geo.size.width - 12
            let rows = arrange(tags: skillsToShow, maxWidth: maxWidth, spacing: 6)

            VStack(alignment: .leading, spacing: 6) {
                ForEach(0..<rows.count, id: \.self) { rowIdx in
                    HStack(spacing: 6) {
                        ForEach(rows[rowIdx], id: \.self) { skill in
                            chip(for: skill)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 120)
    }

    @ViewBuilder
    private func chip(for skill: SkillsEnum) -> some View {
        let isSelected = selected.contains(skill)

        let backgroundColor: Color = {
            if isSelected { return Color.goldenYellow }
            if !editable { return Color.deepBlue.opacity(0.4) }
            return Color.deepBlue
        }()

        let foregroundColor: Color = isSelected ? .black : .white

        Button(action: {
            guard editable else { return }
            toggle(skill)
        }) {
            HStack(spacing: 4) {
                Image(systemName: skill.icon)
                Text(skill.rawValue)
                    .font(.caption)
            }
            .foregroundColor(foregroundColor)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(backgroundColor)
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
        .disabled(!editable)
    }

    private func toggle(_ skill: SkillsEnum) {
        if selected.contains(skill) {
            selected.remove(skill)
        } else {
            selected.insert(skill)
        }
    }

    private func arrange(tags: [SkillsEnum], maxWidth: CGFloat, spacing: CGFloat) -> [[SkillsEnum]] {
        var rows: [[SkillsEnum]] = [[]]
        var curWidth: CGFloat = 0

        for tag in tags {
            let label = UILabel()
            label.text = tag.rawValue
            label.font = .preferredFont(forTextStyle: .caption1)
            label.sizeToFit()
            let textW = label.frame.width
            let chipW = textW + 16 + 24

            let projected = curWidth == 0 ? chipW : curWidth + spacing + chipW

            if projected > maxWidth {
                rows.append([tag])
                curWidth = chipW
            } else {
                rows[rows.count - 1].append(tag)
                curWidth = projected
            }
        }
        return rows
    }
}
