//
//  TimeDelegate.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/31/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

protocol ReadyTimeDelegate:AnyObject {
    func sendTime(time:Int)
}
protocol CaloriesDelegate:AnyObject {
    func sendCalories(calories:Int)
}
