//
//  DashboardRow.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//
import SwiftUI

struct DashboardRow<Right: View>: View {
    let icon: String
    let title: String
    var trailing: Right
    var muted: Bool = false

    init(icon: String, title: String, trailing: Right, muted: Bool = false) {
        self.icon = icon
        self.title = title
        self.trailing = trailing
        self.muted = muted
    }

    init(icon: String, title: String, muted: Bool = false) where Right == EmptyView {
        self.icon = icon
        self.title = title
        self.trailing = EmptyView()
        self.muted = muted
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 28, height: 28, alignment: .center)
                .foregroundStyle(.primary)
            Text(title)
                .font(.body.weight(.medium))
                .foregroundStyle(muted ? .secondary : .primary)
            Spacer()
            trailing
            Image(systemName: "chevron.right")
                .foregroundStyle(Color(.tertiaryLabel))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(.separator), lineWidth: 0.4))
    }
}

#Preview {
    VStack(spacing: 16) {
        DashboardRow(
            icon: "clock.badge.checkmark",
            title: "Banque de temps",
            trailing:
                Text("+2h depuis 24 heures")
                    .font(.subheadline)
                    .foregroundStyle(.green)
        )

        DashboardRow(icon: "hand.raised", title: "Services proposés")

        DashboardRow(icon: "bell", title: "Notifications", muted: true)

        DashboardRow(
            icon: "star",
            title: "Évaluations",
            trailing: Image(systemName: "star.fill").foregroundStyle(.yellow)
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
//    .previewLayout(.sizeThatFits)
}

