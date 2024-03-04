//
//  SearchBarView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchTerm: String
    let prompt: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(KeyVariables.primaryColor)
            
            TextField(prompt, text: $searchTerm)
                .foregroundStyle(.foreground)
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
        }
        .overlay(alignment: .trailing) {
            if !searchTerm.isEmpty {
                Image(systemName: "xmark")
                    .foregroundStyle(KeyVariables.primaryColor)
                    .padding()
                    .onTapGesture {
                        searchTerm = ""
                    }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    SearchBarView(searchTerm: .constant(""), prompt: "Search Skin")
}
