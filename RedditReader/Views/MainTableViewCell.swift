//
//  MainTableViewCell.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

let MainTableCellId = "mainTableCellId"

let NewsCellTitleMarginConstant: CGFloat = 0.0
let NewsCellTitleFontSize: CGFloat = 15.0
let NewsCellTitleDefaultHeight: CGFloat =  25.0
let NewsCellHeight: CGFloat = 100.0

class MainTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    var sub: Sub!
    {
        didSet
        {
            titleLabel.text = sub.title
//            nbCommentsLabel.text = String(sub.nbComments)
//            sinceLabel.text = NSDate(timeIntervalSince1970: sub.createdAt).timeAgoSinceNow()

            if let thumbnail = sub.thumbnail
            {
                let url = NSURL(string: thumbnail)
                let data = NSData(contentsOfURL: url)

                thumbnailView.image = UIImage(data: data)
            }
        }
    }
    
    class func heightForText(text: NSString, bounds: CGRect) -> CGFloat
    {
        var size = text.boundingRectWithSize(CGSizeMake(CGRectGetWidth(bounds) - (NewsCellTitleMarginConstant * 2), CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont.systemFontOfSize(NewsCellTitleFontSize)],
            context: nil)
        return size.height > NewsCellTitleDefaultHeight ? NewsCellHeight + size.height - NewsCellTitleDefaultHeight : NewsCellHeight
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
