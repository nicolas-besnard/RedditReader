//
//  SubCommentCollectionController.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 16/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

class SubCommentCollectionController: ControllerBase
{
    var subComments: SubCommentCollection!
    var subCommentService: SubDetailsService!
    
    func setup()
    {
        
        println("SETUP: SubCommentCollectionController")
        subCommentService = context().subDetailsService
        subComments = context().subComments
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "retrieveSubComments:",
            name: NotificationType.RetrieveSubCommentsNotification.toRaw(),
            object: nil)
    }
    
    func retrieveSubComments(notification: NSNotification)
    {
        if let permalink = notification.subPermalink()
        {
            println("Retrieve comments for \(permalink)")
            subCommentService.get(permalink, completionBlock: { (subComments: [SubComment]) in
                println("RETRIEVE COUNT : \(subComments.count)")
                self.subComments.collection = subComments
            })
        }
        else
        {
            println("Error on retrieving sub comments : permalink not provided.")
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}