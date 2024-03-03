//
//  PlayerCardDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import SwiftUI
import Kingfisher

struct PlayerCardDetailsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var showShareSheeet: Bool = false
    let card: PlayerCard
    
    var body: some View {
        VStack {
            KFImage(URL(string: card.largeArt))
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottom) {
                    HStack(spacing: 20) {
                        CustomButton(image: "download", label: "Download") {
                            homeViewModel.saveImageToGallary(url: card.largeArt)
                        }
                        
                        CustomButton(image: "share", label: "Share") {
                            homeViewModel.downloadImage(url: card.largeArt) {
                                self.showShareSheeet.toggle()
                            }
                        }
                    }
                    .padding(.bottom)
                }
        }
        .alert(isPresented: $homeViewModel.showAlert) {
            if (homeViewModel.alertText.range(of: "Error") != nil) {
                Alert(
                    title: Text(homeViewModel.alertText),
                    primaryButton: .default (Text("Go to Settings")) {
                        self.openSettings()
                    },
                    secondaryButton: .cancel()
                )
            } else {
                Alert(title: Text(homeViewModel.alertText), dismissButton: .cancel(Text("Ok")))
            }
        }
        .sheet(isPresented: $showShareSheeet) {
            if let image = homeViewModel.shareImage {
                ShareItem(item: image)
                    .presentationDetents([.medium, .large])
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Card Details")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
    }
    
    func openSettings() {
        let url = URL(string: UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}

struct CustomButton: View {
    let image: String
    let label: String
    var onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            VStack {
                KeyVariables.primaryColor
                    .mask {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }
                
                Text(label)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
            }
            .frame(height: 60)
        }
    }
}
