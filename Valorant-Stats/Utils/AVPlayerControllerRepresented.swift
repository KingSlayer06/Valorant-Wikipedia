//
//  AVPlayerControllerRepresented.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 02/03/24.
//

import SwiftUI
import AVKit

struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.requiresLinearPlayback = true
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
