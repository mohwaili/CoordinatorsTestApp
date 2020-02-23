//
//  FlowA2ViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 22/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowA3ViewController: UIViewController {
    
    var coordinator: FlowACoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        title = "A3"
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
