//
//  SpraysView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import SwiftUI
import Kingfisher

struct SpraysView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var expandSprayGrid: Bool = false
    @State var selectedSpray: Spray? = nil
    
    @Namespace private var namespace
    
    let columns = [GridItem(.flexible(), spacing: 10),
                   GridItem(.flexible(), spacing: 10),
                   GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        let width = (UIScreen.main.bounds.width - 50)/3
        
        ZStack {
            KeyVariables.secondaryColor
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(homeViewModel.sprays, id: \.uuid) { spray in
                        SprayGridView(spray: spray)
                            .frame(width: width, height: width)
                            .onTapGesture {
                                withAnimation(.bouncy(duration:0.6)) {
                                    expandSprayGrid.toggle()
                                    selectedSpray = spray
                                    AppAnalytics.shared.SprayImageClick(spray: selectedSpray)
                                }
                            }
                    }
                }
                .blur(radius: expandSprayGrid ? 10 : 0)
                .disabled(expandSprayGrid)
                .padding(.horizontal)
                .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
            }
            .onTapGesture {
                withAnimation(.linear(duration:0.2)) {
                    expandSprayGrid = false
                    selectedSpray = nil
                }
            }
            .onAppear {
                AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.sprayScreen)
            }
            .onDisappear {
                withAnimation(.linear(duration:0.2)) {
                    expandSprayGrid = false
                    selectedSpray = nil
                }
            }
            
            if let _ = selectedSpray, expandSprayGrid {
                SprayCardView(expandSprayGrid: $expandSprayGrid, selectedSpray: $selectedSpray, namespace: namespace)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SprayGridView: View {
    let spray: Spray
    
    var body: some View {
        ZStack {
            KFImage(URL(string: spray.fullTransparentIcon ?? ""))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundStyle(KeyVariables.primaryColor)
                        .scaleEffect(3)
                }
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
        }
    }
}

struct SprayCardView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var expandSprayGrid: Bool
    @Binding var selectedSpray: Spray?
    
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            KFImage(URL(string: selectedSpray?.fullTransparentIcon ?? ""))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .matchedGeometryEffect(id: selectedSpray?.uuid, in: namespace)
                .onTapGesture {
                    withAnimation(.linear(duration:0.2)) {
                        expandSprayGrid.toggle()
                        self.selectedSpray = nil
                    }
                }
            
            Button {
                AppAnalytics.shared.SprayShareOnWhatsappClick(spray: selectedSpray)
                KingfisherManager.shared.downloadImage(with: selectedSpray?.fullTransparentIcon ?? "") { image in
                    homeViewModel.shareStickerOnWhatsapp(image: image) {
                        withAnimation(.bouncy(duration:0.2)) {
                            expandSprayGrid = false
                            self.selectedSpray = nil
                        }
                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Text("Share on Whatsapp")
                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    
                    Image("whatsapp-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding()
                .background(KeyVariables.secondaryColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .onTapGesture {
            withAnimation(.bouncy(duration:0.2)) {
                expandSprayGrid = false
                self.selectedSpray = nil
            }
        }
    }
}

#Preview {
    SpraysView()
}
