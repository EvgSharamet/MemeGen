//
//  MemeCollection.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 19.04.2022.
//

import Foundation
import UIKit

class MemeService: IMemeService {
    //MARK: - data
    
    var memeList: [String]?
    var images: [String: UIImage] = [:]
    
    static let urlForFullScreen = "https://apimeme.com/meme?meme=${memeName}&top=${top}&bottom=${bottom}"
    static let urlForCollectionImage = "https://apimeme.com/thumbnail?name=${memeName}"
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background)
    
    //MARK: - internal functions
    
    func getMemeList(completion: @escaping MemeListResponseHandler) {
        if let memeList = memeList {
            completion(.success(memeList))
            return
        }
        updateMemeList(completion: completion)
    }
    
    func getThumbnail(forMeme memeName: String, completion: @escaping ImageResponseHandler) {
        guard let generatedURL = URL(string: MemeService.urlForCollectionImage.replacingOccurrences(of: "${memeName}", with: memeName)) else {
            return
        }

        let cached = queue.sync { self.images[memeName] }
        if let cached = cached {
            completion(.success(cached))
            return
        }
        
        downloadData(url: generatedURL) { result in
            switch result {
            case .success(let imgData):
                guard let img = UIImage(data: imgData) else {
                    completion(.failure(NSError(domain: "MemeService6", code: 000)))
                    return
                }
                
                self.queue.sync {
                    self.images[memeName] = img
                }
                completion(.success(img))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFullImage(forMeme memeName: String, topText: String, bottomText: String, completion: @escaping ImageResponseHandler) {
        guard let generatedURL = URL(string: (MemeService.urlForFullScreen.replacingOccurrences(of: "${memeName}", with: memeName).replacingOccurrences(of: "${top}", with: topText).replacingOccurrences(of: "${bottom}", with: bottomText))) else {
            return
        }
        
        downloadData(url: generatedURL) { result in
            switch result {
            case .success(let imgData):
                guard let img = UIImage(data: imgData) else {
                    completion(.failure(NSError(domain: "MemeService7", code: 000)))
                    return
                }
                completion(.success(img))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func clearCache() {
        self.memeList = []
        self.images = [:]
    }
    
    //MARK: - private functions
    
    private func downloadData(url: URL, completion: @escaping  DownloadDataResponseHandler) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
                return
            }
            completion(.failure(NSError(domain: "MemeService3", code: 000)))
        }
        dataTask.resume()
    }
    
    private func parseMemes(src: String) -> [String] {
        let regex = "<option value=\"(.+)\">[^<]+<\\/option>"
        let r = try! NSRegularExpression(pattern: regex, options: [])
        let matches = r.matches(in: src, options: [], range: NSMakeRange(0,  src.count))
        return matches.compactMap { (src as NSString).substring(with: $0.range(at: 1)) }
    }
    
    private func updateMemeList(completion: @escaping MemeListResponseHandler) {
        guard let url = URL(string: "https://apimeme.com") else {
            completion(.failure((NSError(domain: "MemeService10", code: 0114))))
            return
        }
        
        downloadData(url: url) { data in
            switch data {
            case .success(let rawStr):
                let str = String(decoding: rawStr, as: UTF8.self)
                let memeList = self.parseMemes(src: str)
                self.memeList = memeList
                completion(.success(memeList))
            case .failure(let error):
                print(error)
                completion(.failure(NSError(domain: "MemeService11", code: 0100)))
            }
        }
    }
}


