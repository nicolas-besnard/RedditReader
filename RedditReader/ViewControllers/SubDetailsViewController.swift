//
//  SubDetailsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class SubDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, YTPlayerViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    var sub: Sub!
    var webView: UIWebView!
    var youtubePlayer: YTPlayerView!
    var videoId: String!
    
    var subCommentsCollection: SubCommentCollection!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().postRetrieveSubCommentsFor(sub.permalink)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        context().subComments.collection = []
        subCommentsCollection = context().subComments
        
        subCommentsCollection.addObserver(self, forKeyPath: "collection", options: NSKeyValueObservingOptions.Initial, context: nil)
    
        if let id = videoId
        {
            youtubePlayer = YTPlayerView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
            println("load \(id)")
            youtubePlayer.delegate = self
            youtubePlayer.loadWithVideoId(id)
        }
        else
        {
            webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 1))
            webView.tag = 4242
            webView.delegate = self
            println("web view")
            
            let csss = ["http://b.thumbs.redditmedia.com/x5DddAbZay3Yyu1ww4ZDhf4BhpSadqXbro1PLs_h1CM.css",
                        "http://www.redditstatic.com/old-markdown.bVOmCRk7IMc.css"]
            
            var style = ""
            
            for css in csss
            {
                style += "<link rel=\"stylesheet\" href=\"\(css)\"></head>"
            }
            
            var md = "<!DOCTYPE html><html><head>\(style)<style>body { background-color: white; } .md ul { margin-left: -20px; } .md>* { margin: 5px 0 5px 0; }</style></head><body margin=\"0\"><div style='padding: 0 5px; border: 1px solid #369; border-radius: 7px; margin-right: 15px; word-wrap: break-word;'>" + sub.text.convertHTMLEntities() + "</div></body></html>"
            println(md)
            webView.loadHTMLString(md, baseURL: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "collection"
        {
            println("DATA HAS CHANGE FOR COMMENTS \(self.subCommentsCollection.collection.count)")
            self.tableView.reloadData()
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!)
    {
        println("READY")
        self.tableView.tableHeaderView = playerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return subCommentsCollection.collection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SubDetailsCellId") as SubDetailsTableViewCell
        
        let comment = subCommentsCollection.collection[indexPath.row]
        
        cell.authorLabel.text = comment.author
        
        var md = MMMarkdown.HTMLStringWithMarkdown(comment.body, error: nil)
        md = "<html><head><style>body { font-size:40px; font: normal x-small verdana, arial, helvetica, sans-serif; }</style></head><body><div style='padding: 0 10px; background-color: #fafafa; border: 1px solid #369; border-radius: 7px; margin: 10px; word-wrap: break-word;'>" + md + "</div></body></html>"
        cell.bodyWebView.loadHTMLString(md, baseURL: nil)
        cell.bodyWebView.scrollView.scrollEnabled = false
        cell.bodyWebView.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let comment = subCommentsCollection.collection[indexPath.row]
        let body = comment.body as NSString
        let size = body.boundingRectWithSize(CGSizeMake(CGRectGetWidth(self.tableView.bounds), CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        
        return size.height + 100
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        if webView.tag == 4242
        {
            let result: NSString = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight;")!
            let height = CGFloat(result.floatValue) + 50

            self.webView.frame = CGRect(x: 0, y: 0, width: 320, height: height)
            tableView.tableHeaderView = self.webView
        }
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
    
    deinit
    {
        subCommentsCollection.removeObserver(self, forKeyPath: "collection")
    }
}