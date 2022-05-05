//
//  IMemeService.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 20.04.2022.
//

import UIKit

struct MemeServiceMemeInfo {
   let name: String
}

protocol IMemeService {
    typealias ImageResponse = Result<UIImage, Error>
    typealias ImageResponseHandler = (ImageResponse) -> Void
    typealias MemeListResponse = Result<Void, Error>
    typealias MemeListResponseHandler = (MemeListResponse) -> Void

    var memeCount: Int { get }
    
    func loadMemeList(completion: @escaping MemeListResponseHandler)
    func updateMemeList(completion: @escaping MemeListResponseHandler)
    func getMeme(at index: Int) -> MemeServiceMemeInfo?
    func getThumbnail(forMeme memeName: String, completion: @escaping ImageResponseHandler)
    func getFullImage(forMeme memeName: String, topText: String, bottomText: String, completion: @escaping ImageResponseHandler)
}
