//
//  AgentDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct AgentDetailsView: View {
    @State var selectedAbility: AgentAbilities?
    let agent: Agent
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    ZStack {
                        KFImage(URL(string: agent.background ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 380)
                        
                        KFImage(URL(string: agent.fullPortrait ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 350)
                    }
                    
                    agentName
                    agentType
                    agentDescription
                    
                    Text("Abilities")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(KeyVariables.primaryColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    HStack(spacing: 10) {
                        ForEach(agent.abilities, id: \.self) { ability in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(isAbilitySelected(ability) ? KeyVariables.primaryColor : Color.white, lineWidth: 2)
                                
                                KFImage(URL(string: ability.displayIcon ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                            }
                            .frame(width: 55, height: 55)
                            .onTapGesture {
                                selectedAbility = ability
                            }
                        }
                        
                        Spacer()
                    }
                    
                    if let selectedAbility = selectedAbility {
                        AgentAbilityGridView(ability: selectedAbility)
                            .padding(.vertical)
                    }
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Agent Details")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            selectedAbility = agent.abilities.first
        }
    }
    
    func isAbilitySelected(_ ability: AgentAbilities) -> Bool {
        guard let selectedAbility = selectedAbility else { return false }
        
        return selectedAbility.displayName == ability.displayName
    }
}

extension AgentDetailsView {
    var agentName: some View {
        StatsCellView(label: "Name", icon: nil, value: agent.displayName)
    }
    
    var agentType: some View {
        StatsCellView(label: "Type", icon: agent.role?.displayIcon, value: agent.role?.displayName ?? "")
    }
    
    var agentDescription: some View {
        VStack {
            Group {
                Text("Description: ")
                    .foregroundStyle(KeyVariables.primaryColor)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                + Text(agent.description)
                    .foregroundStyle(.foreground)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
            }
            .multilineTextAlignment(.leading)
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
        }
    }
}

struct AgentAbilityGridView: View {
    let ability: AgentAbilities
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            VStack {
                HStack(alignment: .top) {
                    Text(ability.displayName)
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(KeyVariables.primaryColor)
                    
                    Spacer()
                    
                    KFImage(URL(string: ability.displayIcon ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                }
                
                Group {
                    Text("Description: ")
                        .foregroundStyle(KeyVariables.primaryColor)
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    + Text(ability.description)
                        .foregroundStyle(.foreground)
                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                }
                .multilineTextAlignment(.leading)
            }
            .padding()
        }
    }
}
