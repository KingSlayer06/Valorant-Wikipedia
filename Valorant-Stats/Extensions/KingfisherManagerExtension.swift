//
//  KingfisherExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 28/02/24.
//

import Foundation
import Kingfisher

extension KingfisherManager {
    
    func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
        DispatchQueue.global(qos: .userInteractive).async {
            guard let url = URL.init(string: urlString) else {
                DispatchQueue.main.async {
                    imageCompletionHandler(nil)
                }
                return
            }
            let resource = KF.ImageResource(downloadURL: url)
            
            self.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        imageCompletionHandler(value.image)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        imageCompletionHandler(nil)
                    }
                }
            }
        }
    }
}
