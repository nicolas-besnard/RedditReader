//
//  Notification.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

enum NotificationType: String
{
    case NewSubs = "ReceivedNewSubs"
    case RetrieveSub = "RetrieveSub"
    case RetrieveNextPageSub = "RetrieveNextPageSub"
    case RetrieveSubCommentsNotification = "RetrieveSubCommentsNotification"
}

let _subNameKey = "_subNameKey"
let _afterIdKey = "_afterIdKey"

let _subPermalinkKey = "_subPermalinkKey"

extension NSNotificationCenter
{
    func postNotification(type: NotificationType)
    {
        self.postNotificationName(type.rawValue, object: nil)
    }

    // RetrieveSub

    func postRetrieveSubNotificationFor(subName: String!)
    {
        var userInfo = Dictionary<String, AnyObject>()
        userInfo[_subNameKey] = subName

        let notification = NSNotification(name: NotificationType.RetrieveSub.rawValue, object: nil, userInfo: userInfo)
        self.postNotification(notification)
    }
    
    // Retrieve next page
    
    func postRetrieveNextPageFor(subName: String, afterId: String)
    {
        var userInfo = Dictionary<String, AnyObject>()
        userInfo[_subNameKey] = subName
        userInfo[_afterIdKey] = afterId
        
        let notification = NSNotification(name: NotificationType.RetrieveSub.rawValue, object: nil, userInfo: userInfo)
        self.postNotification(notification)
    }
    
    // Retrieve sub's comments
    
    func postRetrieveSubCommentsFor(permalink: String)
    {
        var userInfo = Dictionary<String, AnyObject>()
        userInfo[_subPermalinkKey] = permalink
        
        let notification = NSNotification(name: NotificationType.RetrieveSubCommentsNotification.rawValue, object: nil, userInfo: userInfo)
        self.postNotification(notification)
    }
}

extension NSNotification
{
    func subName() -> String?
    {
        if let info = userInfo
        {
            return info[_subNameKey] as? NSString
        }
        return nil
    }
    
    func afterId() -> String?
    {
        if let info = userInfo
        {
            return info[_afterIdKey] as? NSString
        }
        return nil
    }
    
    func subPermalink() -> String?
    {
        if let info = userInfo
        {
            return info[_subPermalinkKey] as? NSString
        }
        return nil
    }
}