//
//  Service.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

typealias SubServiceCompletionBlock = (subs: [Sub], beforeId: String!, afterId: String!) -> Void

class ServiceBase
{
    let manager = AFHTTPRequestOperationManager()
    let endpoint = "http://reddit.com"
    
    init()
    {
        self.manager.requestSerializer = AFJSONRequestSerializer()
    }
    
    func handleError(operation: AFHTTPRequestOperation!, error: NSError!)
    {
        println("fail")
        println(error.localizedDescription)
    }
}