//
//  SubSubFlowCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 22/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class FlowCCoordinator: Coordinator {
    
    let router: Router
    var rootViewController: FlowCViewController!
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = FlowCViewController()
        rootViewController.coordinator = self
        router.push(viewController: rootViewController, animated: true, origin: self)
    }
    
}
