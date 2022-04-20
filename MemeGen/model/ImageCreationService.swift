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
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background,
                                      attributes: .concurrent)
    static let shared = ImageCreationService()
    
    func getMemeWithText(memeName: String, topText: String, bottomText: String) -> UIImage? {
        print(memeName)
        print(topText)
        print(bottomText)
        guard let url = URL(string: (ImageCreationService.urlForFullScreen.replacingOccurrences(of: "${memeName}", with: memeName)).replacingOccurrences(of: "${top}", with: topText).replacingOccurrences(of: "${bottom}", with: bottomText)),
              let data = try? Data(contentsOf: url),
              let img = UIImage(data: data)
        else {
            return nil
        }
        return img
    }

    func asyncLoadingImage(memeName: String, completion: @escaping (UIImage?) -> Void) {
        queue.async {
            guard let url = URL(string: ImageCreationService.urlForCollectionImage.replacingOccurrences(of: "${memeName}", with: memeName)),
                  let data = try? Data(contentsOf: url),
                  let img = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(img)
        }
    }
}
