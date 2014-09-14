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
    var subName: String!
    var afterId: String!
    var beforeId: String!
    var pageCount: Int = 0
    
    func setup()
    {
        subs = context().subs
        subService = context().subService
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "retrieveSubsForName:",
            name: NotificationType.RetrieveSub.toRaw(),
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "retrieveNextPageSub:",
            name: NotificationType.RetrieveNextPageSub.toRaw(),
            object: nil)
    }
    
    func retrieveSubsForName(notification: NSNotification)
    {
        pageCount = 0
        afterId = ""
        if let subName = notification.subName()
        {
            self.subName = subName
            println("retrieve \(subName)")
            subService.get(subName, count: 0, afterId: "", completionBlock:{ (subs: [Sub], beforeId: String!, afterId: String!) in
                self.subs.collection = subs
                self.afterId = afterId
                self.beforeId = beforeId
            })
        }
    }
    
    func retrieveNextPageSub(notification: NSNotification)
    {
        pageCount += 25
        println("retrieve \(self.subName)")
        subService.get(self.subName, count: pageCount, afterId: afterId, completionBlock:{ (subs: [Sub], beforeId: String!, afterId: String!) in
            self.subs.collection += subs
            self.afterId = afterId
            self.beforeId = beforeId
        })
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
