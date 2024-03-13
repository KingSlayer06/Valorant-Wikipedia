//
//  BundlesView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI
import Kingfisher

struct BundlesView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    @State private var searchBundle = ""
    
    var filteredBundles: [WeaponBundle] {
        guard !searchBundle.isEmpty else { return homeViewModel.bundles }
        
        return homeViewModel.bundles.filter { $0.displayName.localizedCaseInsensitiveContains(searchBundle) }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    SearchBarView(searchTerm: $searchBundle, prompt: "Search Bundle")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredBundles, id: \.uuid) { bundle in
                            NavigationLink {
                                BundleDetailsView(bundle: bundle)
                            } label: {
                                BundleGridView(bundle: bundle)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
//                                AppAnalytics.shared.WeaponImageClick(weapon: weapon)
                            })
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
//            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.viewAllSkinsScreen)
        }
        .onDisappear {
//            AppAnalytics.shared.ViewAllSkinsBackClick(weaponName: weaponName)
        }
    }
}

struct BundleGridView: View {
    let bundle: WeaponBundle
    
    var body: some View {
        let width = UIScreen.main.bounds.width/2 - 20
        
        ZStack {
            KFImage(URL(string: bundle.verticalPromoImage ?? ""))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundStyle(KeyVariables.primaryColor)
                        .scaleEffect(3)
                }
                .resizable()
                .scaledToFill()
                .frame(maxWidth: width)
            
            LinearGradient(colors: [.black.opacity(0.8), .clear], startPoint: .bottom, endPoint: .top)
                .frame(maxWidth: width)
            
            Text(bundle.displayName)
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .foregroundStyle(KeyVariables.primaryColor)
                .padding()
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
                .frame(maxWidth: width)
        }
        .frame(maxHeight: 300)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    BundlesView()
}
