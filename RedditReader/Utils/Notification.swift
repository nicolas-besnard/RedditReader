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
}

let _subNameKey = "_subNameKey"

extension NSNotificationCenter
{
    func postNotification(type: NotificationType)
    {
        self.postNotificationName(type.toRaw(), object: nil)
    }

    // RetrieveSub

    func postRetrieveSubNotificationFor(subName: String!)
    {
        var userInfo = Dictionary<String, AnyObject>()
        userInfo[_subNameKey] = subName

        let notification = NSNotification(name: NotificationType.RetrieveSub.toRaw(), object: nil, userInfo: userInfo)
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
}