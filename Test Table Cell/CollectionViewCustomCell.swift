//
//  CollectionViewCustomCell.swift
//  Test Table Cell
//
//  Created by Matt Mìnkevich on 4/10/19.
//  Copyright © 2019 Matt Mìnkevich. All rights reserved.
//

import UIKit

protocol CollectionViewDelegate {
    func didTapRemoveItem()
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    var delegate: CollectionViewDelegate?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.addTarget(self, action: #selector(handleRemove), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleRemovePhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRemovePhoto() {
//        print("hey")
//        let viewController = ViewController()
//        viewController.imagesArray.removeAll()
//        viewController.header.reloadData()
        delegate?.didTapRemoveItem()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        setupRemoveButton()
        
    }
    
    fileprivate func setupRemoveButton() {
        addSubview(removeButton)
        removeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
//    @objc func handleRemove(indexPath: IndexPath) {
//        print("remove item")
//        let viewController = ViewController()
//        viewController.imagesArray.remove(at: indexPath.row)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
