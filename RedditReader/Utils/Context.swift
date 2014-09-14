//
//  Context.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

class Context
{
    // Collections
    var subs = SubCollection()
    
    // Services
    var subService = SubService()
//    var subService = MockSubService()
    var subDetailsService = SubDetailsService()
    
    // Controllers
    var subCollectionController = SubCollectionController()
    
    // Others
    var subSuscribed: String! {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("subSuscribed") as? String
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "subSuscribed")
        }
    }
    
    func setup()
    {
        subCollectionController.setup()
    }
    
    func getWebViewController() -> WebViewController
    {
        return getStoryboard().instantiateViewControllerWithIdentifier("WebViewController") as WebViewController
    }
    
    func getSubDetailsViewController() -> SubDetailsViewController
    {
        return getStoryboard().instantiateViewControllerWithIdentifier("SubDetailsViewController") as SubDetailsViewController
    }
    
    private
    
    func getStoryboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}