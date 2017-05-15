//
//  PlayerView.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/19/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var url: URL?
    var item: AVPlayerItem?
    
    // Override UIView property
    override static var layerClass: AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup()
    }
    
    // MARK: Helpers
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func setup(url: URL) {
        self.url = url
        self.item = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: self.item)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }
}
