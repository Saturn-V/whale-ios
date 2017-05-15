//
//  HomeViewController.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 3/27/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var answersCollectionView: UICollectionView!
    
    var currentPage: Page<Answer>?
    var data: [Answer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIWrapper.getAnswers(perPage: 6, page: 0) { page in
            
            if page NetworkError.unauthorizedError {
                
            }
            
            self.currentPage = page
            self.data = page.data
            print("Answer Data: \(String(describing: self.data?.count))")
            self.answersCollectionView.reloadData()
            
            let layout = UICollectionViewFlowLayout()
            
            layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height/2.5)
            
            self.answersCollectionView.collectionViewLayout = layout
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewAnswer" {
            let nextScene = segue.destination as! AnswerViewController
            
            if let indexPath = answersCollectionView.indexPathsForSelectedItems?.first {
                let selectedAnswer = data?[indexPath.row]
                nextScene.answer = selectedAnswer
            }
        }
    }
    
    @IBAction func unwindToAnswers(segue: UIStoryboardSegue) {
        
    }
}

// MARK: - UICollectionViewDataSource protocol
extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let answersCount = self.data?.count {
            return answersCount
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath) as! AnswersCollectionViewCell
        
        if let answer = self.data?[indexPath.row],
           let senderImageURL = self.data?[indexPath.row].question.sender.imageURL,
           let answerImageURL = self.data?[indexPath.row].thumbnailURL,
           let receiverImageURL = self.data?[indexPath.row].question.receiver.imageURL {
            
                cell.senderImageView.af_setImage(withURL: senderImageURL)
//                cell.styleImages()
            
                cell.usernameUILabel.text = "\(answer.question.sender.firstName) \(answer.question.sender.lastName)"
                cell.contentUILabel.text = answer.question.content
            
                cell.answerImageView.af_setImage(withURL: answerImageURL)
                cell.receiverImageView.af_setImage(withURL: receiverImageURL)
                cell.recieverUserameLabel.text = "\(answer.question.receiver.firstName) \(answer.question.receiver.lastName)"
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate protocol
extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected #\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AnswersHeader", for: indexPath) as! AnswersCollectionViewHeader
            
            headerView.label.text = "Latest"
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol
//extension HomeViewController {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: self.view.frame.width, height: self.view.frame.height/2.5)
//    }
//}

// MARK: - UIScrollViewDelegate protocol (used for listening on when last item is on screen)
extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        for indexPath in answersCollectionView.indexPathsForVisibleItems {
            
            // If we reached the end of the page
            if (currentPage?.data.indices.last == indexPath.row) && ((currentPage?.currentPage)! + 1 != currentPage?.totalPages) {
                let next = (currentPage?.currentPage)! + 1
                APIWrapper.getAnswers(perPage: 6, page: next) { page in
                    self.currentPage = page
                    //            self.answersCollectionView.numberOfItems(inSection: page.data.count)
                    self.data?.append(contentsOf: page.data)
                    print("Answer Data: \(String(describing: self.data?.count))")
                    self.answersCollectionView.reloadData()
                }
            }
        }
    }
}
