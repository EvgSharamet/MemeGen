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
    
    var memeService: IMemeService?
    var cellTapListener: ((_ index: Int) -> Void)?
    
    private var imageCollection: UICollectionView?
    private static let identifier = "CollectionViewCell"
    
    //MARK: - internal functions
    
    init(memeService: IMemeService) {
        self.memeService = memeService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        let view = ImageCatalogView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
        
        self.imageCollection = view.imageCollection
        self.imageCollection?.isUserInteractionEnabled = true
        
        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(ImageCatalogCell.self, forCellWithReuseIdentifier: ImageCatalogController.identifier)
        
        MemeService.shared.getMemeList(completion: { result in
            DispatchQueue.main.async { self.imageCollection?.reloadData()}
        })
    }
    
    func updateMemeList() {
        //  showSpinner()
        memeService?.getMemeList { result in
            switch result {
            case .success(_):
                self.imageCollection?.reloadData()
            case .failure(_): break
                // showError
            }
        }
    }
}

extension ImageCatalogController: UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: - internal functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeService.shared.memeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCatalogController.identifier, for: indexPath) as? ImageCatalogCell
        else {
            return UICollectionViewCell()
        }
        
        guard let memeList = memeService?.memeList, memeList.indices.contains(indexPath.row)
        else {
            print(memeService)
            print(memeService?.memeList)
            return cell
        }
    
        let memeName = memeList[indexPath.row]
        
        let placeholderData = ImageCatalogCell.CellData(
            name: memeName,
            image: UIImage(named: "placeholder")
        )
        
        cell.configure(data: placeholderData)
        
        memeService?.getThumbnail(forMeme: memeName) { image  in
            switch image {
            case .success(let image):
                cell.configure(data: ImageCatalogCell.CellData(name: memeName, image: image) )
                
            case .failure(let error):
                print(error)
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellTapListener?(indexPath.row)
    }
}
