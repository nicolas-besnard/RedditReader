//
//  SubDetailsTableViewCell.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 14/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import UIKit

let SubDetailsCellId = "SubDetailsCellId"

class SubDetailsTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var subTextLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
