//
//  ImageCreationService.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 18.04.2022.
//

import Foundation
import UIKit

class ImageCreationService {
    static let url =  "https://apimeme.com/create/${memeName}"
    static let shared = ImageCreationService()
    
    func getMemeWithText(memeName: String, topText: String, bottomText: String) -> UIImage? {
        print(memeName)
        print(ImageCreationService.url.replacingOccurrences(of: "${memeName}" , with: String(memeName)))
        guard let url = URL(string: ImageCreationService.url.replacingOccurrences(of: "${memeName}" , with: memeName)),
              let data = try? Data(contentsOf: url),
              let img = UIImage(data: data)
        else {
            return nil
        }
        return img
    }
}
