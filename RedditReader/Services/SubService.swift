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
//        let subEndpoint = self.endpoint + "/" + subName + ".json"
        let subEndpoint = self.endpoint + "/.json"
        manager.GET(subEndpoint,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("success")

                var subs: [Sub] = []
                
                let json = JSONValue(responseObject)
                
                let jsonSub = json["data"]["children"].array
                
                for sub in jsonSub!
                {
                    let subData = sub["data"]
                    
                    let newSub = Sub()
                    newSub.title = subData["title"].string
                    newSub.thumbnail = nil
                    newSub.url = subData["url"].string
                    newSub.id = subData["id"].string
                    newSub.permalink = subData["permalink"].string
                    newSub.createdAt = subData["created_utc"].double
                    newSub.sub = subData["subreddit"].string
                    
                    if let thumbnail = subData["thumbnail"].string
                    {
                        newSub.thumbnail = thumbnail
                    }
                    
                    subs += [newSub]
                }
                
                completionBlock(subs: subs, beforeId: json["data"]["before"].string, afterId: json["data"]["after"].string)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("fail")
                println(error.localizedDescription)
            }
        )
    }
}