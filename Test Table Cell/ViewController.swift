//
//  ViewController.swift
//  Test Table Cell
//
//  Created by Matt Mìnkevich on 4/9/19.
//  Copyright © 2019 Matt Mìnkevich. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewDelegate {
   
    func didTapRemoveItem() {
        print("delegate works")
        imagesArray.removeAll()
        header.reloadData()
    }
    
    
    let cellId = "cellId"
    let collectionCellId = "CollectionCellId"
    let headerId = "headerId"
    
    let header: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        
        header.delegate = self
        header.dataSource = self
        
        header.alwaysBounceHorizontal = true
        
        header.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        
        header.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
//    let button: UIButton = {
//        let b = UIButton()
//        b.backgroundColor = .yellow
//        return b
//    }()
    
    var imagesArray = [UIImage]() // empty array
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 130).isActive = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        collectionViewHeader.addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: collectionViewHeader.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: collectionViewHeader.centerYAnchor).isActive = true
//        collectionViewHeader.backgroundColor = .blue
        return collectionViewHeader
    }
    
    @objc fileprivate func handleSelectPhoto() {
        print("select photo")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 100, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 200)
    }
    
    //////
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    let imageView = UIImageView()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! CustomCollectionViewCell
////        cell.backgroundColor = .red
            cell.imageView.image = imagesArray[indexPath.row]
            cell.delegate = self
        return cell
    }
    
    
    
    ////
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

class CustomHeader: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as! UIImage
        imagesArray.append(selectedImage)
        let cell = CustomCollectionViewCell()
  //      cell.imageView.image = selectedImage.withRenderingMode(.alwaysOriginal)
        header.reloadData()
        dismiss(animated: true)
    }


}
