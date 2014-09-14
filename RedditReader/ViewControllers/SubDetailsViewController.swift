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
        var md = MMMarkdown.HTMLStringWithMarkdown(sub.text, error: nil)
        md = "<html><head><style>body { font-size:40px; }</style></head><body><div style='padding: 5px; background-color: #fafafa; border: 1px solid #369; border-radius: 7px; margin: 10px; word-wrap: break-word;'>" + md + "</div></body></html>"
        println("md")
        println(md)
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
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
//        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}