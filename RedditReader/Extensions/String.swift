//
//  String.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 13/09/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

extension String
{
    func contains(string: String) -> Bool
    {
        if self.rangeOfString(string, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) == nil
        {
            return false
        }
        return true
    }
}