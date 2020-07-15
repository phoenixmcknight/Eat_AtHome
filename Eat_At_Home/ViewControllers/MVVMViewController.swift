//
//  MVVMViewController.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 7/15/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

protocol MVVMViewControlerProtocol {
    associatedtype T
    init(with viewModel:T)
}

class                             MVVMViewController<U>:UIViewController,MVVMViewControlerProtocol {
    
    typealias T = U
    
    var viewModel:U
    
    required init(with viewModel: U) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
