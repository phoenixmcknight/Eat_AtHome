//
//  File.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 3/30/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

protocol IntoleranceViewControllerDelegate:AnyObject {
func sendIntoleranceSelection(intolerance:String,isAdding:Bool)

}
