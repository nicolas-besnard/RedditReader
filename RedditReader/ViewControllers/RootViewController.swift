//
//  ViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate
{
    var subCollection: SubCollection!
    
    var infiniteScrollingIsLoading = false
    var pullToRefreshIsLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        subCollection = context().subs
        
        setupObserver()
        setupNavigationItems()
        
//        tableView.addPullToRefreshWithActionHandler {
//            println("PULL")
//            NSNotificationCenter.defaultCenter().postRetrieveSubNotificationFor(context().subSuscribed)
//            self.pullToRefreshIsLoading = true
//        }
        
        tableView.addInfiniteScrollingWithActionHandler {
            println("NEW DATA")
            NSNotificationCenter.defaultCenter().postNotification(NotificationType.RetrieveNextPageSub)
            self.infiniteScrollingIsLoading = true
        }
        
        if let sub = context().subSuscribed
        {
            NSNotificationCenter.defaultCenter().postRetrieveSubNotificationFor(sub)
        }
        else
        {
            onRightButton()
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    private func setupObserver()
    {
        self.subCollection.addObserver(self, forKeyPath: "collection", options: NSKeyValueObservingOptions.Initial, context: nil)
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle
    {
        return .FullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController?
    {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
    
    func onRightButton()
    {
        let popoverVC = storyboard?.instantiateViewControllerWithIdentifier("ChoseSubsViewController") as UIViewController
        popoverVC.modalPresentationStyle = .Popover
        let popoverController = popoverVC.popoverPresentationController
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.permittedArrowDirections = .Any
            popoverController.delegate = self
        }
        presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    private func setupNavigationItems() {
        var rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action: "onRightButton")
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "collection"
        {
            println("DATA HAS CHANGE \(self.subCollection.collection.count)")
            self.tableView.reloadData()
            if infiniteScrollingIsLoading
            {
                self.tableView.infiniteScrollingView.stopAnimating()
                infiniteScrollingIsLoading = false
            }
            if pullToRefreshIsLoading
            {
                self.tableView.pullToRefreshView.stopAnimating()
                pullToRefreshIsLoading = false
            }
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    // MARK: - TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(MainTableCellId) as MainTableViewCell
        cell.sub = self.subCollection.collection[indexPath.row]
    
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let text = self.subCollection.collection[indexPath.row].title
        return MainTableViewCell.heightForText(text, bounds: tableView.bounds)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedSub = self.subCollection.collection[indexPath.row]
        
        if selectedSub.url.contains("www.reddit.com")
        {
            let viewController = context().getSubDetailsViewController()
            viewController.sub = selectedSub
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else if selectedSub.url.contains("youtube.com") ||  selectedSub.url.contains("youtu.be")
        {
            UIApplication.sharedApplication().openURL(NSURL(string: selectedSub.url))
        }
        else
        {
            let web = context().getWebViewController()
            web.sub = selectedSub
            self.navigationController?.pushViewController(web, animated: true)
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.subCollection.collection.count
    }
}