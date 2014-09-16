//
//  ReadSubService.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

typealias ReadSubServiceCompletionBlock = (subComments: [SubComment]) -> Void

class SubDetailsService: ServiceBase
{
    func get(url: String, completionBlock: ReadSubServiceCompletionBlock)
    {
        let realUrl = "http://reddit.com/" + url + ".json?depth=1"
        
        println("SubDetails \(realUrl)")
        manager.GET(realUrl,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("success")
                
                var subComments: [SubComment] = []
                
                let json = JSONValue(responseObject).array
                
                for content in json!
                {
                    for comment in content["data"]["children"].array!
                    {
                        if comment["kind"].string! != "t1"
                        {
                            break
                        }
                        
                        let newComment = SubComment()
                        
                        if let author = comment["data"]["author"].string
                        {
                            newComment.author = author
                        }
                        
                        if let body = comment["data"]["body"].string
                        {
                            newComment.body = body
                        }
                        
                        if let createdAt = comment["data"]["created_utc"].double
                        {
                            newComment.createdAt = createdAt
                        }
                        
                        subComments.append(newComment)
                    }
                }
                
                completionBlock(subComments: subComments)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("fail")
                println(error.localizedDescription)
            }
        )
    }
}