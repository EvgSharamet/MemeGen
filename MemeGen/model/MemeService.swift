//
//  MemeCollection.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 19.04.2022.
//

import Foundation
import UIKit
import CoreData

class MemeService: IMemeService {
    //MARK: - types
    
    typealias DownloadDataResponse = Result<Data, Error>
    typealias DownloadDataResponseHandler = (DownloadDataResponse) -> Void
    
    private struct Const {
        static let urlForFullScreen = "https://apimeme.com/meme?meme=${memeName}&top=${top}&bottom=${bottom}"
        static let urlForCollectionImage = "https://apimeme.com/thumbnail?name=${memeName}"
    }
    
    //MARK: - data
    
    private let memeInfoRepo =  MemeInfoRepo()
    private var images: [String: UIImage] = [:]
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background,
                                      attributes: .concurrent)
    
    var memeCount: Int {
        memeInfoRepo.count
    }
    
    func loadMemeList(completion: @escaping MemeListResponseHandler) {
        memeInfoRepo.load(completion: completion)
    }
    
    func updateMemeList(completion: @escaping MemeListResponseHandler) {
        guard let url = URL(string: "https://apimeme.com") else {
            completion(.failure((NSError(domain: "MemeService10", code: 0114))))
            return
        }
        downloadData(url: url) { data in
            switch data {
            case .success(let rawStr):
                let str = String(decoding: rawStr, as: UTF8.self)
                let memeList = self.parseMemes(src: str)
                DispatchQueue.main.async {
                    self.clearCache()
                    do {
                        try self.storeMemeList(memeList)
                    } catch {
                        print("updateMemeList error: \(error)")
                        completion(.failure(error))
                        return
                    }
                    print(memeList)
                    completion(.success(Void()))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getMeme(at index: Int) -> MemeServiceMemeInfo? {
        let obj = memeInfoRepo.getElement(at: index)
        let retVal = MemeServiceMemeInfo(name: obj.name)
        return retVal
    }
    
    func getThumbnail(forMeme memeName: String, completion: @escaping ImageResponseHandler) {
        guard let generatedURL = URL(string: Const.urlForCollectionImage.replacingOccurrences(of: "${memeName}", with: memeName)) else {
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
                self.queue.sync(flags: .barrier) {
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
        guard let generatedURL = URL(string: (Const.urlForFullScreen.replacingOccurrences(of: "${memeName}", with: memeName).replacingOccurrences(of: "${top}", with: topText).replacingOccurrences(of: "${bottom}", with: bottomText))) else {
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
    
    //MARK: - private functions
    
    private func clearCache() {
        try? memeInfoRepo.clear()
        images = [:]
    }
    
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
    
    private func storeMemeList(_ memeList: [String]) throws {
        let objs = memeList.map { MemeInfoRepo.MemeInfo(name: $0) }
        memeInfoRepo.appendElements(objs)
        try self.memeInfoRepo.save()
    }
}


private class MemeInfoRepo {
    //MARK: - types
    
    typealias VoidResult = Result<Void, Error>
    typealias VoidResultHandler = (VoidResult) -> Void
    
    struct MemeInfo {
        let name: String
    }
    
    private class Element1: NSManagedObject {
        @NSManaged var name: String
    }
    
    private struct Const {
        static let persistentContainerName = "MemeModel"
        static let persistentEntityName = "Meme"
    }
    
    //MARK: - data
    
    public var count: Int {
        guard let sections = fetchedResultsController.sections, sections.indices.contains(0) else { return 0 }
        return sections[0].numberOfObjects
    }
    
    private let persistentContainer = NSPersistentContainer(name: Const.persistentContainerName)
    private var objectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    private lazy var fetchedResultsController: NSFetchedResultsController<Meme> = {
        let fetchRequest = Meme.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let retVal = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                managedObjectContext: objectContext,
                                                sectionNameKeyPath: nil,
                                                cacheName: nil)
        return retVal
    }()
    
    //MARK: - funcs
    
    func getElement(at index: Int) -> MemeInfo {
        let indexPath = IndexPath(row: index, section: 0)
        let obj = fetchedResultsController.object(at: indexPath)
        return MemeInfo(name: obj.name ?? "<no-name>")
    }
    
    func appendElement(_ meme: MemeInfo) {
        let obj = NSEntityDescription.insertNewObject(forEntityName: Const.persistentEntityName,
                                                      into: objectContext) as! Meme
        obj.name = meme.name
    }
    
    func appendElements(_ memes: [MemeInfo]) {
        memes.forEach {
            appendElement($0)
        }
    }
    
    func load(completion: @escaping VoidResultHandler) {
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                try self.fetchedResultsController.performFetch()
            } catch {
                completion(.failure(error))
                return
            }
            completion(.success(Void()))
        }
    }
    
    func save() throws {
        try objectContext.save()
        try fetchedResultsController.performFetch()
    }
    
    func clear() throws {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: Const.persistentEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        try objectContext.execute(deleteRequest)
        try fetchedResultsController.performFetch()
    }
}
