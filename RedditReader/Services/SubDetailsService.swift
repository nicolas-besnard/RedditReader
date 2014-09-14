//
//  ReadSubService.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

typealias ReadSubServiceCompletionBlock = (subs: [Sub]) -> Void

class SubDetailsService: ServiceBase
{
    func get(url: String, completionBlock: ReadSubServiceCompletionBlock)
    {
        println("SubDetails \(url)")
        manager.GET(url + ".json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("success")
                let json = JSONValue(responseObject)
                
                println(json.array)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("fail")
                println(error.localizedDescription)
            }
        )
    }
}