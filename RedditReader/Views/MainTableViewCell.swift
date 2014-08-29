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
    
    var sub: Sub!
    {
        didSet
        {
            titleLabel.text = sub.title
            
            if let thumbnail = sub.thumbnail
            {
                let url = NSURL(string: thumbnail)
                let data = NSData(contentsOfURL: url)

                thumbnailView.image = UIImage(data: data)
            }
        }
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
