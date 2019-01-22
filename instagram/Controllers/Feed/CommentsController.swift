//
//  CommentsController.swift
//  instagram
//
//  Created by Daniel Dramond on 20/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class CommentsController: UIViewController {
    
    var post: Post? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Comments"
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = UIColor.getHexColor("FEFEFE")
        
        setupNavigationBar()
        setupViews()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    func setupViews() {
        
        self.collectionView.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
        _ = collectionView.anchor(view.topAnchor, view.rightAnchor, view.bottomAnchor, view.leftAnchor, 0, 0, 0, 0, width: 0, height: 0)
    }
}

extension CommentsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let comments = self.post?.comments else { return 0 }
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        
        if let comments = self.post?.comments {
            
            if let user = self.post?.user {
                
                let username = user.username ?? ""
                let comment = comments[indexPath.item].comment ?? ""
                
                let combinedHeight: CGFloat = textHeight(username, comment)
                
                if (combinedHeight <= 10 + 34 + 10) {
                    height = 10 + 34 + 22 + 10
                } else {
                    height = 10 + combinedHeight + 10 + 2 + 22
                }
            }
        }
        
        print("HEIGHT: \(height)")
        
        return CGSize(width: self.collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
         
        if let comments = self.post?.comments {
            cell.comment = comments[indexPath.item]
        }
        
        return cell
    }
}
