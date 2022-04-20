//
//  ImageCollectionController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class ImageCatalogController: UIViewController {
    //MARK: - types
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 10.0
        static let itemHeight: CGFloat = 150.0
    }
    
    //MARK: - data
    
    private var imageCollection: UICollectionView?
    private static let identifier = "CollectionViewCell"
    
    //MARK: - internal functions 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5.withAlphaComponent(0.5)
        let view = ImageCatalogView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
        
        self.imageCollection = view.imageCollection

        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(ImageCatalogCell.self, forCellWithReuseIdentifier: ImageCatalogController.identifier)
        
        MemeCollectionService.shared.createURLSeccion()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.imageCollection?.reloadData()
        })
    }
}

extension ImageCatalogController: UICollectionViewDataSource, UICollectionViewDelegate  {
    //MARK: - internal functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeCollectionRepoService.shared.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCatalogController.identifier, for: indexPath) as? ImageCatalogCell else {
            return UICollectionViewCell()
        }
        cell.configure(data: ImageCatalogCell.CellData(name: MemeCollectionRepoService.shared.collection[indexPath.row].name,
                                                       image: MemeCollectionRepoService.shared.collection[indexPath.row].image))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

extension ImageCatalogController: UICollectionViewDelegateFlowLayout {
    //MARK: - internal functions
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        let height = width
        return CGSize(width: width, height: height )
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 4

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return floor(finalWidth)
    }
}
