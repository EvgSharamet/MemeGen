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
    
    var cellTapListener: ((_ index: Int) -> Void)?
    
    private let memeService: IMemeService
    private var imageCollection: UICollectionView?
    private var spinner: UIView?
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
        let view = ImageCatalogView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
        
        self.imageCollection = view.imageCollection
        self.imageCollection?.isUserInteractionEnabled = true
        self.spinner = view.spinner
        view.updateButton.addTarget(self, action: #selector(updateMemeList), for: .touchUpInside)

        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(ImageCatalogCell.self, forCellWithReuseIdentifier: ImageCatalogController.identifier)
        
        memeService.getMemeList(forceReload: false, completion: { result in
            DispatchQueue.main.async { self.imageCollection?.reloadData()}
        })
    }
    
    //MARK: - private functions
    
    @objc private func updateMemeList() {
        self.showSpinner()
        self.memeService.clearCache()
        self.memeService.getMemeList(forceReload: true) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.imageCollection?.reloadData()
                    self.hideSpinner()
                case .failure(_):
                    self.hideSpinner()
                    let alert = UIAlertController(title: "Warning", message: "Failed to update collection", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    private func showSpinner() {
        spinner?.isHidden = false
    }
    
    private func hideSpinner() {
        spinner?.isHidden = true
    }
}

extension ImageCatalogController: UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: - internal functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeService.memeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCatalogController.identifier, for: indexPath) as? ImageCatalogCell
        else {
            return UICollectionViewCell()
        }
        
        guard let memeList = memeService.memeList, memeList.indices.contains(indexPath.row)
        else {
            return cell
        }
        
        let memeName = memeList[indexPath.row]
        
        let placeholderData = ImageCatalogCell.CellData(
            name: memeName,
            image: UIImage(named: "placeholder")
        )
        
        cell.configure(data: placeholderData)
        
        memeService.getThumbnail(forMeme: memeName) {[weak self] result  in
            switch result {
            case .success(let image):
                let data = ImageCatalogCell.CellData(
                    name: memeName,
                    image: image)
                DispatchQueue.main.async {
                    self?.updateCell(at: indexPath, withData: data)
                }
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    //MARK: - private functions
    
    private func updateCell(at indexPath: IndexPath, withData data: ImageCatalogCell.CellData) {
        guard let collectionView = imageCollection,
              let cell = collectionView.cellForItem(at: indexPath) as? ImageCatalogCell
        else {
            return
        }
        cell.configure(data: data)
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
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellTapListener?(indexPath.row)
    }
}
