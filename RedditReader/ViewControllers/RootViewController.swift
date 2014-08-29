//
//  ViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var subCollection: SubCollection!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        subCollection = context().subs
        
        setupObserver()
        NSNotificationCenter.defaultCenter().postRetrieveSubNotificationFor("leagueoflegends")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    private func setupObserver()
    {
        self.subCollection.addObserver(self, forKeyPath: "collection", options: NSKeyValueObservingOptions.Initial, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "collection"
        {
            println("DATA HAS CHANGE \(self.subCollection.collection.count)")
            self.tableView.reloadData()
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    // Table View
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        println(indexPath.row)
        var cell = tableView.dequeueReusableCellWithIdentifier(MainTableCellId) as? MainTableViewCell
        cell!.sub = self.subCollection.collection[indexPath.row]
        return cell
    }

    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.subCollection.collection.count
    }
}

