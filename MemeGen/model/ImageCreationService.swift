//
//  ImageCreationService.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 18.04.2022.
//

import Foundation
import UIKit

class ImageCreationService {
    static let urlForFullScreen = "https://apimeme.com/meme?meme=${memeName}&top=${top}&bottom=${bottom}"
    static let urlForCollectionImage = "https://apimeme.com/thumbnail?name=${memeName}"
    static let shared = ImageCreationService()
    
    func getMemeWithText(memeName: String, topText: String, bottomText: String) -> UIImage? {
        guard let url = URL(string: (ImageCreationService.urlForFullScreen.replacingOccurrences(of: "${memeName}", with: memeName)).replacingOccurrences(of: "${top}", with: topText).replacingOccurrences(of: "${bottom}", with: bottomText)),
              let data = try? Data(contentsOf: url),
              let img = UIImage(data: data)
        else {
            return nil
        }
        return img
    }
    
    func getMemeforCollection(memeName: String) -> UIImage? {
        guard let url = URL(string: ImageCreationService.urlForFullScreen),
              let data = try? Data(contentsOf: url),
              let img = UIImage(data: data)
        else {
            return nil
        }
        return img
    }
}
