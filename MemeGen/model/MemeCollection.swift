//
//  MemeCollection.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 19.04.2022.
//

import Foundation
import UIKit

struct MemeItem {
    let name: String
    var image: UIImage?
}

class MemeCollectionRepoService {
    var collection: [MemeItem] = []
    
    static let shared = MemeCollectionRepoService()

    func setImageForItem(image: UIImage?, index: Int) {
        collection[index].image = image
    }
    
    func addItem(_ item: MemeItem) -> Int {
        collection.append(item)
        return collection.indices.last ?? 0
    }
}
