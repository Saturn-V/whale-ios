//
//  AnswerViewController.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/17/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit
import AVFoundation

class AnswerViewController: UIViewController {
    
    var answer: Answer?
    
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var contentUILabel: UILabel!
    
    
    @IBOutlet weak var playerView: PlayerView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewComments" {
            let nextScene = segue.destination as! CommentsViewController
            
            self.playerView.pause()
            
            nextScene.answer = answer
        }
    }
    
    @IBAction func unwindToAnswer(segue: UIStoryboardSegue) {
        
    }
    
    var playing = true
    
    @IBAction func playerController(_ sender: UIButton) {
        if playing {
            playing = false
            self.playerView.pause()
            sender.setImage(#imageLiteral(resourceName: "PlayIcon"), for: UIControlState.normal)
        } else {
            playing = true
            self.playerView.play()
            sender.setImage(#imageLiteral(resourceName: "PauseButton"), for: UIControlState.normal)
        }
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.playerView.pause()
        self.performSegue(withIdentifier: "unwindToAnswers", sender: self)
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.playerView.setup(url: (answer?.videoURL)!)
        self.playerView.play()
        
        self.senderImageView.af_setImage(withURL: (answer?.question.sender.imageURL)!)
        self.usernameUILabel.text = "\(answer?.question.sender.firstName ?? "None") \(answer?.question.sender.lastName ?? "None")"
        self.contentUILabel.text = answer?.question.content
    }
}
