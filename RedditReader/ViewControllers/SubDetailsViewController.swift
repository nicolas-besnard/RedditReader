//
//  SubDetailsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class SubDetailsViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var webView: UIWebView!
    var sub: Sub!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.webView.delegate = self
        let md = MMMarkdown.HTMLStringWithMarkdown(sub.text, error: nil)
         webView.loadHTMLString(md, baseURL: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        if navigationType == UIWebViewNavigationType.LinkClicked
        {
            println("link clicked \(request.URL)")
            let web = context().getWebViewController()
            web.url = request.URL.absoluteString
            self.navigationController?.pushViewController(web, animated: true)
            return false
        }
        else
        {
            return true
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}