//
//  SubCollectionController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

class SubCollectionController: ControllerBase
{
    var subs: SubCollection!
    var subService: SubServiceProtocol!
    var afterId: String!
    var beforeId: String!
    
    func setup()
    {
        subs = context().subs
        subService = context().subService
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "retrieveSubsForName:",
            name: NotificationType.RetrieveSub.toRaw(),
            object: nil)
    }
    
    func retrieveSubsForName(notification: NSNotification)
    {
        if let subName = notification.subName()
        {
            println("retrieve \(subName)")
            subService.get(subName, completionBlock: { (subs: [Sub], beforeId: String!, afterId: String!) in
                self.subs.collection = subs
            })
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
