
//  ViewController.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

private let cellId = "cellId"
private let headerCellId = "headerCellId"

protocol PostCellDelegate {
    func goToCommentsController(_ post: Post)
}

class ViewController: UIViewController {
    
    var stories = [Story]()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = UIColor.getHexColor("FEFEFE")
        
        handleGetData()
        
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
    
    let customView: CustomView = {
        let view = CustomView()
        return view
    }()
    
    func setupViews() {
        
        self.collectionView.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.register(StoriesHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        self.view.addSubview(collectionView)
        _ = collectionView.anchor(view.topAnchor, view.rightAnchor, view.bottomAnchor, view.leftAnchor, 0, 0, 0, 0, width: 0, height: 0)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: HEADER
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 86)
    }
    
    // MARK: CELLS
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as! StoriesHeaderCell
        
        header.stories = self.stories
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let post = self.posts[indexPath.item]
        let topHeight: CGFloat = 50
        let postHeight: CGFloat = self.view.frame.width / (4 / 5)
        let actionsHeight: CGFloat = 44
        
        var likesHeight: CGFloat = 0
        if let numberOfLikes = post.likes {
            if numberOfLikes > 0 {
                likesHeight = 22 - 6
            }
        }
        
        let usernameHeight: CGFloat = self.handleEstimatedFrame("\(post.user?.username ?? "") ", font: UIFont(name: "HelveticaNeue-Medium", size: 12) ?? .systemFont(ofSize: 12)).height
        let detailsHeight: CGFloat = self.handleEstimatedFrame("\(post.text ?? "") ", font: UIFont(name: "HelveticaNeue", size: 12) ?? .boldSystemFont(ofSize: 12)).height + 4
        
        var addCommentHeightHeight: CGFloat = 0
        if let numberOfComments = post.comments?.count {
            if numberOfComments > 0 {
                addCommentHeightHeight = 22 - 6
            }
        }
        
        return CGSize(width: self.collectionView.frame.width, height: topHeight + postHeight + actionsHeight + likesHeight + usernameHeight + detailsHeight + addCommentHeightHeight + 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        
        cell.delegate = self
        cell.post = posts[indexPath.item]
        
        return cell
    }
}
