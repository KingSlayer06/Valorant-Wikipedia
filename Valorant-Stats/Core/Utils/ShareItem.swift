//
//  ShareImage.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 28/02/24.
//

import Foundation
import SwiftUI

struct ShareItem: UIViewControllerRepresentable {
    
    let item: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let controller = UIActivityViewController(activityItems: [ item ], applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
