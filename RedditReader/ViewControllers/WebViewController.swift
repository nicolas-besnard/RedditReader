//
//  WebViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 02/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var webView: UIWebView!
    
    var sub: Sub! {
        didSet {
            self.url = sub.url
        }
    }
    var url: String!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        if let hasSub = sub
//        {
//            let url = NSURL(string: hasSub.url)
//            self.webView.loadRequest(NSURLRequest(URL: url))
//        }
        let nsUrl = NSURL(string: url)

        webView.loadRequest(NSURLRequest(URL: nsUrl))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}