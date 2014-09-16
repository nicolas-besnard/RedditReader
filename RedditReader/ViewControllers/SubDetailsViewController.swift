//
//  SubDetailsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class SubDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    var webViewHeight: CGFloat?
    
    var sub: Sub!
    var webView: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        webView.delegate = self
        
        var md = MMMarkdown.HTMLStringWithMarkdown(sub.text, error: nil)
        md = "<html><head><style>body { font-size:40px; font: normal x-small verdana, arial, helvetica, sans-serif; }</style></head><body><div style='padding: 0 10px; background-color: #fafafa; border: 1px solid #369; border-radius: 7px; margin: 10px; word-wrap: break-word;'>" + md + "</div></body></html>"
        webView.loadHTMLString(md, baseURL: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SubDetailsCellId") as SubDetailsTableViewCell

        return cell
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        let result: NSString = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight;")!
        let height = CGFloat(result.floatValue) + 50

        self.webView.frame = CGRect(x: 0, y: 0, width: 320, height: height)
        tableView.tableHeaderView = self.webView
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}