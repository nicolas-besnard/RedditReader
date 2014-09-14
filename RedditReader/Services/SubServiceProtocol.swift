//
//  SubServiceProtocole.swift
//  RedditReader
//
//  Created by Nicolas Besnard on 29/08/2014.
//  Copyright (c) 2014 Nicolas Besnard. All rights reserved.
//

import Foundation

protocol SubServiceProtocol
{
    func get(subName: String, count: Int, afterId: String, completionBlock: SubServiceCompletionBlock)
}