//
//  MainTableViewCell.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

let MainTableCellId = "mainTableCellId"

class MainTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nbCommentsLabel: UILabel!
    @IBOutlet weak var sinceLabel: UILabel!
    
    @IBOutlet weak var titleMarginConstrain: NSLayoutConstraint!
    var sub: Sub!
    {
        didSet
        {
            titleLabel.text = sub.title
            nbCommentsLabel.text = String(sub.nbComments)
            sinceLabel.text = NSDate(timeIntervalSince1970: sub.createdAt).timeAgoSinceNow()

            if let thumbnail = sub.thumbnail
            {
                let url = NSURL(string: thumbnail)
                let data = NSData(contentsOfURL: url)

                thumbnailView.image = UIImage(data: data)
            }
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
            
        titleLabel.preferredMaxLayoutWidth = 5
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
