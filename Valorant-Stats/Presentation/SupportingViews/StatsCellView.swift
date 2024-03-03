//
//  StatsCellView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct StatsCellView: View {
    let label: String
    let icon: String?
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(label):")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                
                Spacer()
                
                if icon != nil {
                    KFImage(URL(string: icon!))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                
                Text(value)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
        }
    }
}

#Preview {
    StatsCellView(label: "Weapon", icon: nil, value: "Odin")
}
