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
    
    var sub: Sub!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let url = NSURL(string: sub.url)
        self.webView.loadRequest(NSURLRequest(URL: url))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
