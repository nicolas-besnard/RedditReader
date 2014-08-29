//
//  SubService.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

class SubService: ServiceBase, SubServiceProtocol
{
    func get(subName: String, completionBlock: SubServiceCompletionBlock)
    {
        let subEndpoint = self.endpoint + "/" + subName + ".json"
        
        manager.GET(subEndpoint,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("success")
                let json = JSONValue(responseObject)
                let subs = json["data"]["children"]
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("fail")
                println(error.localizedDescription)
            }
        )
    }
}