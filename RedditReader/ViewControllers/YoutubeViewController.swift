//
//  YoutubeViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 16/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class YoutubeViewController: UIViewController, YTPlayerViewDelegate
{
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    
    var videoId: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.youtubePlayerView.delegate = self
        
        if let id = videoId
        {
            self.youtubePlayerView.loadWithVideoId(id)
        }
        else
        {
            println("no id")
        }
    }
    
    func playerView(playerView: YTPlayerView!, receivedError error: YTPlayerError)
    {
        println("ERROR")
    }
    
    func playerView(playerView: YTPlayerView!, didChangeToState state: YTPlayerState)
    {
        println("NEW STAT \(state.value)")
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!)
    {
        playerView.playVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}