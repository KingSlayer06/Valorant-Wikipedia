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
    @State var selectedRole: AgentRole?
    @State var viewAppeared = false
    @Binding var hideView: (Bool, Bool)
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if homeViewModel.showShimmer {
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
                        if homeViewModel.showShimmer {
                            ForEach(0..<10) { _ in
                                ShimmerEffect()
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        } else {
                            ForEach(homeViewModel.filteredAgents.indices, id: \.self) { index in
                                NavigationLink {
                                    AgentDetailsView(agent: homeViewModel.filteredAgents[index], hideView: $hideView)
                                } label: {
                                    AgentGridView(agent: homeViewModel.filteredAgents[index])
                                        .opacity(viewAppeared ? 1 : 0)
                                        .scaleEffect(viewAppeared ? 1 : 0.5)
                                        .animation(.easeInOut(duration: 0.3).delay(0.075 * Double(index + 1)), value: viewAppeared)
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    homeViewModel.selectedAgent = homeViewModel.filteredAgents[index]
                                    AppAnalytics.shared.AgentImageClick(agent: homeViewModel.filteredAgents[index])
                                })
                            }
                        }
                    }
                    .overlayPreferenceValue(MAnchorKey.self, { value in
                        GeometryReader { geometry in
                            ForEach(homeViewModel.filteredAgents, id: \.uuid) { agent in
                                if let anchor = value[agent.uuid], homeViewModel.selectedAgent != agent {
                                    let rect = geometry[anchor]
                                    
                                    AgentImageView(agent: agent, size: rect.size)
                                        .offset(x: rect.minX, y: rect.minY)
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                    })
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewAppeared = true
            
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.agentScreen)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                hideView.0 = false
                hideView.1 = false
                homeViewModel.selectedAgent = nil
            }
        }
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
                
                Color.clear
                    .frame(width: 170, height: 170)
                    .padding(.bottom)
                    .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                        return [agent.uuid : anchor]
                    })
            }
        }
    }
}

struct AgentImageView: View {
    let agent: Agent
    let size: CGSize
    
    var body: some View {
        KFImage(URL(string: agent.fullPortrait ?? ""))
            .placeholder {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundStyle(KeyVariables.primaryColor)
                    .scaleEffect(3)
            }
            .resizable()
            .scaledToFit()
            .frame(maxWidth: size.width, maxHeight: size.height)
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
                AppAnalytics.shared.AgentRoleClick(role: selectedRole)
                
                withAnimation(.bouncy(duration: 0.35)) {
                    selectedRole = nil
                    homeViewModel.getFilteredAgents(agentRole: selectedRole)
                }
            }
    }
    
    var selectedAgentRole: some View {
        ForEach(homeViewModel.agentRoles, id: \.uuid) { role in
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
                    AppAnalytics.shared.AgentRoleClick(role: selectedRole)
                    
                    withAnimation(.bouncy(duration: 0.35)) {
                        selectedRole = role
                        homeViewModel.getFilteredAgents(agentRole: selectedRole)
                    }
                }
        }
    }
}

#Preview {
    AgentsView(hideView: .constant((false, false)))
        .environmentObject(HomeViewModel())
}
