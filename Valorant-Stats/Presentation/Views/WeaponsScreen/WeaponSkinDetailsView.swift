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
    @State private var player: AVPlayer?
    @State var selectedSkinLevel: WeaponSkinLevel?
    @State var selectedChroma: WeaponSkinChromas?
    
    @State private var videoCompleteObserver: Any?
    @State private var foregroundEnteredObserver: Any?
    
    let skin: WeaponSkin
    
    var isNoColorsPresent: Bool {
        return !skin.chromas.filter { $0.swatch == nil }.isEmpty
    }
    
    var body: some View {
        ZStack {
            KeyVariables.secondaryColor
            
            VStack(alignment: .leading) {
                KFImage(URL(string: selectedChroma?.fullRender ?? ""))
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(KeyVariables.primaryColor)
                            .scaleEffect(3)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                
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
                                    AppAnalytics.shared.WeaponSkinDetailsColorClick(color: selectedChroma?.displayName)
                                    if let url = selectedChroma?.streamedVideo {
                                        Task {
                                            await loadPlayerItem(URL(string: url)!)
                                        }
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom)
                
                if KeyVariables.showSkinDetails {
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
                                        AppAnalytics.shared.WeaponSkinDetailsLevelClick(level: "Level \(index+1)")
                                        
                                        if let url = selectedSkinLevel?.streamedVideo {
                                            Task {
                                                await loadPlayerItem(URL(string: url)!)
                                            }
                                        }
                                    }
                            }
                            
                            Spacer()
                        }
                    }
                    
                    if selectedSkinLevel?.streamedVideo == nil {
                        Text("No Video")
                            .font(Font.custom(KeyVariables.primaryFont, size: 20))
                            .foregroundStyle(.foreground)
                            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            }
                    } else {
                        if let player = player {
                            AVPlayerControllerRepresentable(player: player)
                                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                }
                                .padding(.vertical)
                                .onAppear {
                                    addObserver()
                                }
                                .onDisappear {
                                    removeObserver()
                                }
                        }
                    }
                    
                    Spacer()
                }
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
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.weaponSkinDetailsScreen)
            selectedSkinLevel = skin.levels.first
            selectedChroma = skin.chromas.first
            
            if let url = selectedSkinLevel?.streamedVideo, KeyVariables.showSkinDetails {
                Task {
                    player = AVPlayer()
                    await loadPlayerItem(URL(string: url)!)
                }
            }
        }
        .onDisappear {
            stopPlayback()
            AppAnalytics.shared.WeaponSkinDetailsBackClick(skin: skin)
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
        removeObserver()

        foregroundEnteredObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { notification in
            print("App entered foreground state!")
            Task {
                await player?.play()
            }
        }

        guard let currentItem = player?.currentItem else { return }
        videoCompleteObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: currentItem,
                                               queue: nil) { notification in
            print("Video Complete")
            Task {
                await player?.seek(to: .zero)
                await player?.play()
            }
        }
    }
    
    func removeObserver() {
        if let foregroundEnteredObserver = foregroundEnteredObserver {
            NotificationCenter.default.removeObserver(foregroundEnteredObserver)
            self.foregroundEnteredObserver = nil
        }

        if let videoCompleteObserver = videoCompleteObserver {
            NotificationCenter.default.removeObserver(videoCompleteObserver)
            self.videoCompleteObserver = nil
        }
    }

    func stopPlayback() {
        removeObserver()
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        player = nil
    }
    
    func loadPlayerItem(_ videoURL: URL) async {
        player?.pause()
        removeObserver()

        let asset = AVAsset(url: videoURL)
        do {
            let (_, _, _) = try await asset.load(.tracks, .duration, .preferredTransform)
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let player else { return }

        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
        addObserver()
        player.play()
    }
}

extension WeaponSkinDetailsView {
    
}
