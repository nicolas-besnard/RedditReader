//
//  SubDetailsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class SubDetailsViewController: UIViewController
{
    @IBOutlet weak var webView: UIWebView!
    var sub: Sub!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        println("MARKDOWN")
        let md = MMMarkdown.HTMLStringWithMarkdown(sub.text, error: nil)
         webView.loadHTMLString(md, baseURL: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}