//
//  ChoseSubsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 14/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

var ChoseSubsCellId = "ChoseSubTableViewCellId"

class ChoseSubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    let subsCat = ["leagueoflegends", "movies"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar()
    {
        self.title = "Chose sub to show"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "onCancelButton")
    }
    
    func onCancelButton()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return subsCat.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(ChoseSubsCellId) as UITableViewCell
        cell.textLabel!.text = subsCat[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let subName = subsCat[indexPath.row]
        
        NSNotificationCenter.defaultCenter().postRetrieveSubNotificationFor(subName)
        onCancelButton()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}