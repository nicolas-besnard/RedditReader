// Playground - noun: a place where people can play

import UIKit

var url = "http://youtube.com?v=AZERTYUIOPML"
//url = "http://youtu.be/AZERTYUIOPML"

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

YoutubeVideoIDExtractor.extractId(url)
