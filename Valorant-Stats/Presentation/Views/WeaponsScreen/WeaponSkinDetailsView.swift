//
//  WeaponSkinDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import SwiftUI
import Kingfisher
import AVKit

struct WeaponSkinDetailsView: View {
    @State var player: AVPlayer?
    @State var selectedSkinLevel: WeaponSkinLevel?
    @State var selectedChroma: WeaponSkinChromas?
    
    @State private var videoCompleteObserver: Any?
    @State private var foregroundEnteredObserver: Any?
    
    let skin: WeaponSkin
    
    var isNoColorsPresent: Bool {
        return !skin.chromas.filter { $0.swatch == nil }.isEmpty
    }
    
    var body: some View {
        let width = UIScreen.main.bounds.width - 15
        
        ZStack {
            KeyVariables.secondaryColor
            
            VStack {
                KFImage(URL(string: selectedChroma?.fullRender ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Colors")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isNoColorsPresent {
                    Text("No Colors Available")
                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                        .foregroundStyle(.foreground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack(spacing: 10) {
                    ForEach(skin.chromas,  id: \.uuid) { chroma in
                        if let swatch = chroma.swatch {
                            KFImage(URL(string: swatch))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .border(isSelected(chroma) ? .white : .clear, width: 2)
                                .onTapGesture {
                                    selectedChroma = chroma
                                    
                                    if let url = selectedChroma?.streamedVideo {
                                        player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: url)!))
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(skin.levels.indices, id: \.self) { index in
                            Text("Level \(index+1)")
                                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                .foregroundStyle(isSelected(skin.levels[index]) ? .white : .black)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(isSelected(skin.levels[index]) ? KeyVariables.primaryColor : Color.white)
                                }
                                .onTapGesture {
                                    selectedSkinLevel = skin.levels[index]
                                    
                                    if let url = selectedSkinLevel?.streamedVideo {
                                        player?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: url)!))
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                }
                
                if let player = player {
                    AVPlayerControllerRepresented(player: player)
                        .frame(width: width, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        }
                        .padding(.vertical)
                        .onAppear {
                            player.play()
                            addObserver()
                        }
                        .onDisappear {
                            removeObserver()
                        }
                } else {
                    Text("No Video")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                        .frame(width: width - 10, height: 200)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(skin.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            selectedSkinLevel = skin.levels.first
            selectedChroma = skin.chromas.first
            
            if let url = selectedSkinLevel?.streamedVideo {
                player = AVPlayer(url: URL(string: url)!)
            }
        }
    }
    
    func isSelected(_ level: WeaponSkinLevel) -> Bool {
        guard let selectedSkinLevel = selectedSkinLevel else { return false }
        
        return selectedSkinLevel.uuid == level.uuid
    }
    
    func isSelected(_ chroma: WeaponSkinChromas) -> Bool {
        guard let selectedChroma = selectedChroma else { return false }
        
        return selectedChroma.uuid == chroma.uuid
    }
    
    func addObserver() {
        foregroundEnteredObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { notification in
            print("App entered foreground state!")
            player?.play()
        }
        
        videoCompleteObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem,
                                               queue: nil) { notification in
            print("Video Complete")
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    func removeObserver() {
        if let foregroundEnteredObserver = foregroundEnteredObserver {
            NotificationCenter.default.removeObserver(foregroundEnteredObserver)
        }
    
        if let videoCompleteObserver = videoCompleteObserver {
            NotificationCenter.default.removeObserver(videoCompleteObserver)
        }
    }
}

extension WeaponSkinDetailsView {
    
}
