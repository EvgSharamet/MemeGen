//
//  MemeCollectionService.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 18.04.2022.
//

import Foundation
import UIKit

class MemeCollectionService {
    static let shared = MemeCollectionService()
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background,
                                      attributes: .concurrent)
    
    func parseMemes(src: String) -> [String] {
        let regex = "<option value=\"(.+)\">[^<]+<\\/option>"
        let r = try! NSRegularExpression(pattern: regex, options: [])
        let matches = r.matches(in: src, options: [], range: NSMakeRange(0,  src.count))
        return matches.compactMap { (src as NSString).substring(with: $0.range(at: 1)) }
    }
    
    func createURLSeccion() {
        URLSession.shared.dataTask(with: URL(string: "https://apimeme.com")!) { data, response, error in
            if let error = error {
                print("ERROR: \(error), ")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            let memeList = self.parseMemes(src: str)
            for meme in memeList {
                let index = MemeCollectionRepoService.shared.addItem(MemeItem(name: meme, image: nil))
                ImageCreationService.shared.asyncLoadingImage(memeName: meme) {
                    MemeCollectionRepoService.shared.setImageForItem(image: $0, index: index)
                }
            }
        }.resume()
    }
}
