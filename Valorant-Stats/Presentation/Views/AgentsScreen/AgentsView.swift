//
//  AgentsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct AgentsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State var selectedRole: AgentRole?
    @State private var selectedAgent: Agent?
    
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 240), spacing: 20)]
    
    var agentRoles: [AgentRole] {
        var roles = [AgentRole]()
        
        homeViewModel.agents.forEach { agent in
            if (!roles.contains(where: { $0.displayName == agent.role!.displayName })) {
                roles.append(agent.role!)
            }
        }
        
        return roles
    }
    
    var filteredAgents: [Agent] {
        guard let selectedRole = selectedRole else { return homeViewModel.agents }
        
        return homeViewModel.agents.filter { $0.role?.displayName == selectedRole.displayName }
    }
    
    var body: some View {
        if #available(iOS 27.1, *), horizontalSizeClass == .regular {
            ArrangementView {
                agentList(usesSplitSelection: true)
            } secondary: {
                agentDetail
            }
            .arrangementViewStyle(.split.axes(.horizontal))
        } else {
            agentList(usesSplitSelection: false)
        }
    }

    private func agentList(usesSplitSelection: Bool) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if homeViewModel.showAgentsShimmer {
                                ForEach(0..<5) { _ in
                                    ShimmerEffect()
                                        .frame(width: 80, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            } else {
                                allAgentRoles
                                selectedAgentRole
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.vertical)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        if homeViewModel.showAgentsShimmer {
                            ForEach(0..<10) { _ in
                                ShimmerEffect()
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        } else {
                            ForEach(filteredAgents, id: \.uuid) { agent in
                                agentCell(agent, usesSplitSelection: usesSplitSelection)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.agentScreen)
        }
    }

    @ViewBuilder
    private func agentCell(_ agent: Agent, usesSplitSelection: Bool) -> some View {
        if usesSplitSelection {
            Button {
                selectedAgent = agent
                AppAnalytics.shared.AgentImageClick(agent: agent)
            } label: {
                AgentGridView(agent: agent)
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink {
                AgentDetailsView(agent: agent)
            } label: {
                AgentGridView(agent: agent)
            }
            .simultaneousGesture(TapGesture().onEnded {
                AppAnalytics.shared.AgentImageClick(agent: agent)
            })
        }
    }

    @ViewBuilder
    private var agentDetail: some View {
        if let selectedAgent {
            AgentDetailsView(agent: selectedAgent)
        } else {
            detailPlaceholder("Select an Agent", systemImage: "person.2")
        }
    }

    private func detailPlaceholder(_ title: String, systemImage: String) -> some View {
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
    
    func isSelected(_ role: AgentRole) -> Bool {
        guard let selectedRole = selectedRole else { return false }
        
        return selectedRole.displayName == role.displayName
    }
}

struct AgentGridView: View {
    let agent: Agent
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            VStack {
                Text(agent.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .padding(.vertical)
                    .foregroundStyle(.foreground)
                
                KFImage(URL(string: agent.fullPortrait ?? ""))
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(KeyVariables.primaryColor)
                            .scaleEffect(3)
                    }
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
            }
        }
    }
}

extension AgentsView {
    
    var allAgentRoles: some View {
        Text("All")
            .font(Font.custom(KeyVariables.primaryFont, size: 15))
            .foregroundStyle(selectedRole == nil ? .white : .black)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(selectedRole == nil ? KeyVariables.primaryColor : Color.white)
            }
            .onTapGesture {
                selectedRole = nil
                AppAnalytics.shared.AgentRoleClick(role: selectedRole)
            }
    }
    
    var selectedAgentRole: some View {
        ForEach(agentRoles, id: \.uuid) { role in
            Text(role.displayName)
                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                .foregroundStyle(isSelected(role) ? .white : .black)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected(role) ? KeyVariables.primaryColor : Color.white)
                }
                .onTapGesture {
                    selectedRole = role
                    AppAnalytics.shared.AgentRoleClick(role: selectedRole)
                }
        }
    }
}

#Preview {
    AgentsView()
        .environmentObject(HomeViewModel())
}
