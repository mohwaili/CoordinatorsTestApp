//
//  SubSubViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 21/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class SubSubViewController: UIViewController {

    weak var coordinator: SubSubFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }

}
