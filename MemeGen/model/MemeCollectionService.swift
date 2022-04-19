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
            print("memeList = \(memeList)")
        }.resume()
    }
    
    func downloadMemesCollection() -> [UIImage?] {
        return [nil]
    }
    
    
    
}
