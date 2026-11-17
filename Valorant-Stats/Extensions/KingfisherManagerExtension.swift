//
//  KingfisherExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 28/02/24.
//

import Foundation
import Kingfisher
import UIKit

enum ImageDownloadError: LocalizedError {
    case invalidURL(String)
    case failed(KingfisherError)

    var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString):
            return "Invalid image URL: \"\(urlString)\""
        case .failed(let error):
            return error.localizedDescription
        }
    }
}

extension KingfisherManager {
    func downloadImage(with urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw ImageDownloadError.invalidURL(urlString)
        }

        try Task.checkCancellation()

        let image: UIImage = try await withCheckedThrowingContinuation { continuation in
            retrieveImage(with: KF.ImageResource(downloadURL: url), options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value.image)
                case .failure(let error):
                    continuation.resume(throwing: ImageDownloadError.failed(error))
                }
            }
        }

        try Task.checkCancellation()
        return image
    }
}
