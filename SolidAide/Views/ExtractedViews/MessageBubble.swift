import SwiftUI
import SwiftData

struct MessageBubble: View {
    let message: ChatClass
    let isCurrentUser: Bool

    var body: some View {
        HStack {
            if isCurrentUser { Spacer() }

            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.message)
                    .padding(12)
                    .foregroundColor(isCurrentUser ? .white : .primary)
                    .background(
                        isCurrentUser ? Color.mintGreen : Color.mintGreen.opacity(0.2),
                        in: UnevenRoundedRectangle(
                            topLeadingRadius: 16,
                            bottomLeadingRadius: isCurrentUser ? 16 : 0,
                            bottomTrailingRadius: isCurrentUser ? 0 : 16,
                            topTrailingRadius: 16
                        )
                    )

                Text(message.dateTime, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: 250, alignment: isCurrentUser ? .trailing : .leading)

            if !isCurrentUser { Spacer() }
        }
    }
}
