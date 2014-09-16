//
//  YoutubeVideoIDExtractor.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 16/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

class YoutubeVideoIDExtractor
{
    class func extractId(url: NSString) -> String!
    {
        var id: String!
       
        let youtuDotBe = url.componentsSeparatedByString("youtu.be/")
        let youtubeDotCom = url.componentsSeparatedByString("v=")
        
        if youtuDotBe.count > 1
        {
            let str = youtuDotBe[1] as NSString
            id = str.substringToIndex(11)
        }
        else if youtubeDotCom.count > 1
        {
            let str = youtubeDotCom[1] as NSString
            id = str.substringToIndex(11)
        }

        return id
    }
}