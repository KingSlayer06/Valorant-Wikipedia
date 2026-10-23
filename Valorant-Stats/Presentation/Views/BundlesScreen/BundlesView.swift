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
    
    let columns = [GridItem(.flexible(minimum: 0), spacing: 20),
                   GridItem(.flexible(minimum: 0), spacing: 20)]
    
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
                    if homeViewModel.showBundlesShimmer {
                        ShimmerEffect()
                            .frame(height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.vertical)
                    } else {
                        SearchBarView(searchTerm: $searchBundle, prompt: "Search Bundle")
                    }
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        if homeViewModel.showBundlesShimmer {
                            ForEach(0..<24) { _ in
                                ShimmerEffect()
                                    .aspectRatio(0.7, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        } else {
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
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            LinearGradient(colors: [.black.opacity(0.8), .clear], startPoint: .bottom, endPoint: .top)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Text(bundle.displayName)
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .foregroundStyle(KeyVariables.primaryColor)
                .padding()
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
        }
        .aspectRatio(0.7, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    BundlesView()
}
