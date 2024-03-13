//
//  AgentContractsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import SwiftUI
import Kingfisher

struct AgentContractsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = AgentContractsViewModel()
    @Namespace var namespace
    
    @State var selectedAgent: Agent?
    @State var selectedContract: AgentContract?
    @State var selectedChapter1: Bool = true
    
    @State var chapter1Items: [AnyObject] = []
    @State var chapter2Items: [AnyObject] = []
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    chapterSelection
                        .padding(.vertical)
                    
                        if let selectedContract = selectedContract {
                            
                            ZStack {
                                Text(selectedContract.displayName)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(KeyVariables.primaryColor, lineWidth: 2)
                            }
                            .frame(width: UIScreen.main.bounds.width - 40, height: 350)
                            .padding(.vertical)
                            
                            if selectedChapter1 {
                                ChaptersView(chapter: selectedContract.content.chapters[0])
                            } else {
                                ChaptersView(chapter: selectedContract.content.chapters[1])
                            }
                        }
                    
                    allAgents
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: selectedAgent) {
            selectedChapter1 = true
        }
        .onAppear {
            selectedAgent = homeViewModel.agents.first
            selectedContract = homeViewModel.contracts.first(where: { $0.displayName.contains(selectedAgent!.displayName) })
            
            selectedContract?.content.chapters[0].levels.forEach { level in
                switch level.reward.type {
                    case "Spray":
                    break
                    case "PlayerCard":
                    break
                    case "Title":
                    break
                    case "Currency":
                    break
                    default:
                        break
                }
            }
        }
    }
    
    func getAgent(from contract: AgentContract) -> Agent? {
        for agent in homeViewModel.agents {
            if contract.displayName.contains(agent.displayName) {
                return agent
            }
        }
        
        return nil
    }
    
    func isSelected(_ agent: Agent) -> Bool {
        guard let selectedAgent = selectedAgent else { return false }
        
        if agent.displayName == selectedAgent.displayName {
            return true
        }
        
        return false
    }
}

struct AgentContractGridView: View {
    let agent: Agent
    let isSelected: Bool
    let onClick: () -> Void
    
    var body: some View {
        let size: CGFloat = isSelected ? 140 : 120
        ZStack {
            VStack(spacing: 5) {
                KFImage(URL(string: agent.displayIcon))
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(KeyVariables.primaryColor)
                            .scaleEffect(3)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
                
                Text(agent.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 12))
                    .foregroundStyle(.foreground)
            }
            .padding()
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(isSelected ? .white : KeyVariables.primaryColor, lineWidth: 2)
        }
        .frame(width: size, height: size)
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .animation(.smooth, value: isSelected)
        .onTapGesture {
            onClick()
        }
    }
}

struct ChaptersView: View {
    let chapter: ContractChapters
    @State var selectedLevel: ContractLevel?
    
    var body: some View {
        let width = UIScreen.main.bounds.width/CGFloat(chapter.levels.count) - 10
        
        HStack {
            ForEach(chapter.levels.indices, id:\.self) { index in
                ZStack {
                    Text(chapter.levels[index].reward.type)
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isSelected(chapter.levels[index]) ? .white : KeyVariables.primaryColor, lineWidth: 2)
                }
                .frame(width: width, height: width)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .contentShape(RoundedRectangle(cornerRadius: 5))
                .animation(.smooth, value: isSelected(chapter.levels[index]))
                .onTapGesture {
                    selectedLevel = chapter.levels[index]
                }
            }
        }
        .onAppear {
            selectedLevel = chapter.levels.first
        }
    }
    
    func isSelected(_ level: ContractLevel) -> Bool {
        guard let selectedLevel = selectedLevel else { return false }
        
        if level.xp == selectedLevel.xp {
            return true
        }
        
        return false
    }
}

extension AgentContractsView {
    
    var chapterSelection: some View {
        VStack {
            HStack {
                Text("Chapter 1")
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(selectedChapter1 ? KeyVariables.primaryColor : .white)
                    .frame(width: 120)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedChapter1 = true
                    }
                
                Text("Chapter 2")
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(selectedChapter1 == false ? KeyVariables.primaryColor : .white)
                    .frame(width: 120)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedChapter1 = false
                    }
            }
            
            Rectangle()
                .fill(KeyVariables.primaryColor)
                .frame(height: 2)
                .frame(width: 120)
                .frame(maxWidth: 240, alignment: selectedChapter1 ? .leading : .trailing)
                .animation(.snappy, value: selectedChapter1)
        }
    }
    
    var allAgents: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(homeViewModel.contracts, id: \.uuid) { contract in
                    if let agent = getAgent(from: contract) {
                        AgentContractGridView(agent: agent, isSelected: isSelected(agent)) {
                            selectedAgent = agent
                            selectedContract = contract
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    AgentContractsView()
}
