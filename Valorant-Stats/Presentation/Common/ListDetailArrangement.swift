//
//  ListDetailArrangement.swift
//  Valorant-Stats
//

import SwiftUI

// When horizontalSizeClass == .regular
//      Shows a list and its detail screen side by side in `ArrangementView`.
// else
//      Shows only the list and pushes the detail screen on `NavigationStack`.
struct ListDetailArrangement<List: View, Detail: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @ViewBuilder let list: (_ usesSplitSelection: Bool) -> List
    @ViewBuilder let detail: () -> Detail

    var body: some View {
        if #available(iOS 27.1, *), horizontalSizeClass == .regular {
            ArrangementView {
                list(true)
            } secondary: {
                // Fill the pane so details narrower than it stay centered.
                detail()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(KeyVariables.secondaryColor)
            }
            .arrangementViewStyle(.split.axes(.horizontal))
        } else {
            list(false)
        }
    }
}


struct ListDetailLink<Destination: View, Label: View>: View {
    let usesSplitSelection: Bool
    let isSelected: Bool
    
    // Push destination view on `NavigationStack`
    var onTap: () -> Void = {}
    
    // Show destination view side-by-side in `ArrangementView`
    let select: () -> Void
    
    @ViewBuilder let destination: () -> Destination
    @ViewBuilder let label: () -> Label

    var body: some View {
        if usesSplitSelection {
            Button {
                select()
                onTap()
            } label: {
                label()
                    .overlay {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.white, lineWidth: 3)
                        }
                    }
            }
            .buttonStyle(.plain)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
        } else {
            NavigationLink(destination: destination, label: label)
                .simultaneousGesture(TapGesture().onEnded(onTap))
        }
    }
}

struct ListDetailPlaceholder: View {
    let title: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(KeyVariables.primaryColor)
            Text(title)
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .foregroundStyle(.foreground)
            Text("Choose an item to view its details.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(KeyVariables.secondaryColor)
    }
}
