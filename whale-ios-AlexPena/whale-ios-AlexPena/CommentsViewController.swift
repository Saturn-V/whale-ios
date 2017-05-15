//
//  CommentsViewController.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/21/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import UIKit

class CommentsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    var answer: Answer?
    var currentPage: Page<Comment>?
    var data: [Comment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APIWrapper.getComments(answerId: (answer?.id)!, perPage: 6, page: 0) { page in
            self.currentPage = page
            self.data = page.data
            self.commentsCollectionView.reloadData()
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource protocol
extension CommentsViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let commentsCount = self.data?.count {
            return commentsCount
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCollectionViewCell
        
        if let comment = self.data?[indexPath.row] {
            cell.commenterImageView.af_setImage(withURL: comment.commenter.imageURL!)
            cell.usernameLabel.text = "\(comment.commenter.firstName) \(comment.commenter.lastName)"
            cell.contentLabel.text = comment.content
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate protocol
extension CommentsViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected #\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CommentsHeader", for: indexPath) as! CommentsCollectionViewHeader
            
            headerView.label.text = "Comments"
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }

    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol
extension CommentsViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height/7)
    }
}
