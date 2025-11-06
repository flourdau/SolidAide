/*
 __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
 |     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
 (|                      (|
 */

import SwiftUI


struct ColoredSegmentedControl: View {
    @Binding var selection: Bool   // true = Oui, false = Non
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { selection = true }) {
                Text("Oui")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(selection ? Color("mintGreen") : Color(.systemGray5))
                    .foregroundColor(selection ? .white : .primary)
            }
            
            Button(action: { selection = false }) {
                Text("Non")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(!selection ? Color("warmCoral") : Color(.systemGray5))
                    .foregroundColor(!selection ? .white : .primary)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}
