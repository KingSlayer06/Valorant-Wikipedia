//
//  SideMenuRowView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

struct SideMenuRowView: View {
    @Binding var selectedOption: SideMenuOptionsModel
    let option: SideMenuOptionsModel
    
    var onClick: () -> Void
    
    private var isSelected: Bool {
        return selectedOption == option
    }
    
    var body: some View {
        HStack {
            Text(option.title)
                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                .foregroundStyle(.primary)
            
            Spacer()
            
            if option == .patchNotes {
                Image(systemName: "link")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
            }
        }
        .padding(.leading)
        .frame(height: 44)
        .background(isSelected ? KeyVariables.primaryColor : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            onClick()
        }
    }
}

#Preview {
    SideMenuRowView(selectedOption: .constant(.agents), option: SideMenuOptionsModel.agents, onClick: {})
}
