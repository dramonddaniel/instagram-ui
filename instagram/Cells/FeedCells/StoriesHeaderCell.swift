//
//  StoriesHeaderCell.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class StoriesHeaderCell: BaseCell {
    
    var stories = [Story]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = true
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    override func setupViews() {
        
        self.backgroundColor = UIColor.getHexColor("FEFEFE")
        
        self.collectionView.register(StoryCell.self, forCellWithReuseIdentifier: cellId)
        
        self.addSubview(collectionView)
        _ = collectionView.anchor(self.topAnchor, self.rightAnchor, self.bottomAnchor, self.leftAnchor, 0, 0, 0, 0, width: 0, height: 0)
    }
}

extension StoriesHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.height - 12, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoryCell
        
        cell.story = stories[indexPath.item]
        
        return cell
    }
}
