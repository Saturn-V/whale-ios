//
//  AnswersCollectionViewCell.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/5/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit

class AnswersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var contentUILabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    
    @IBOutlet weak var receiverImageView: UIImageView!
    @IBOutlet weak var recieverUserameLabel: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layout = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        
        layout.frame.size = CGSize(width: (self.superview?.frame.size.width)!, height: layout.frame.size.width)
        return layout
    }
}
