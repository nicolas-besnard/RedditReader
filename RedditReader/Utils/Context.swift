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
//    var subService = SubService()
    var subService = MockSubService()
    
    // Controllers
    var subCollectionController = SubCollectionController()
    
    func setup()
    {
        subCollectionController.setup()
    }
}