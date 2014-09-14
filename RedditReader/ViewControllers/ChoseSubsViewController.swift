//
//  ChoseSubsViewController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 14/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

class ChoseSubsViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Chose sub to show"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "onCancelButton")
    }
    
    func onCancelButton()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}