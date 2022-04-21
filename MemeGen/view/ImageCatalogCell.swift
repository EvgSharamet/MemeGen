//
//  ImageCatalogCell.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class ImageCatalogCell: UICollectionViewCell {
    //MARK: - types
    
    struct CellData{
        let name: String
        let image: UIImage?
    }

    //MARK: - data
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    //MARK: - public functions
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: CellData){
        imageView.image = data.image
        nameLabel.text = data.name
    }
    
    //MARK: - private functions
    
    private func prepare() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .random
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        nameLabel.textAlignment = .center
        nameLabel.font = UIConst.imageNameFont
    }
}
