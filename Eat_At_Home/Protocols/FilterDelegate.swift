//
//  FilterDelegate.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 6/1/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

enum AddOrRemoveFilter {
    case add
    case remove
}

protocol FilterDelegate:AnyObject {
    func sendFilter(addOrRemove:AddOrRemoveFilter, filterString:String?, filterNumber:Int?, filter:Filters) 
}
