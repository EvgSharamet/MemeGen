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
    var images: [UIImage]?
    
    static let shared = MemeService()
    static let urlForFullScreen = "https://apimeme.com/meme?meme=${memeName}&top=${top}&bottom=${bottom}"
    static let urlForCollectionImage = "https://apimeme.com/thumbnail?name=${memeName}"
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background,
                                      attributes: .concurrent)
    
    //MARK: - internal functions
    
    func getMemeList(completion: @escaping MemeListResponseHandler){
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

        downloadData(url: generatedURL) { result in
            switch result {
            case .success(let imgData):
                guard let img = UIImage(data: imgData) else {
                    completion(.failure(NSError(domain: "MemeService", code: 000)))
                    return
                }
                completion(.success(img))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFullImage(forMeme memeName: String, topText: String, bottomText: String, completion: @escaping ImageResponseHandler) {
        
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
            completion(.failure(NSError(domain: "MemeService", code: 000)))
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
        URLSession.shared.dataTask(with: URL(string: "https://apimeme.com")!) { data, response, error in
            if let error = error {
                print("ERROR: \(error), ")
                completion(.failure((NSError(domain: "MemeService", code: 010))))
                return
            }
            
            guard let data = data else {
                print("no data")
                completion(.failure((NSError(domain: "MemeService", code: 011))))
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            let memeList = self.parseMemes(src: str)
            self.memeList = memeList
            completion(.success(memeList))
        }.resume()
    }
}
    
    
