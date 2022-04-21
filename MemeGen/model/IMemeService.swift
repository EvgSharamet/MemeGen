//
//  IMemeService.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 20.04.2022.
//

import UIKit

protocol IMemeService {
    typealias ImageResponse = Result<UIImage, Error>
    typealias ImageResponseHandler = (ImageResponse) -> Void
    typealias MemeListResponse = Result<[String], Error>
    typealias MemeListResponseHandler = (MemeListResponse) -> Void
    typealias DownloadDataResponse = Result<Data, Error>
    typealias DownloadDataResponseHandler = (DownloadDataResponse) -> Void
    
    var memeList: [String]? {get}
    
    func getMemeList(completion: @escaping MemeListResponseHandler)
    func getThumbnail(forMeme memeName: String, completion: @escaping ImageResponseHandler)
    func getFullImage(forMeme memeName: String, topText: String, bottomText: String, completion: @escaping ImageResponseHandler)
}
