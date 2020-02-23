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
    var completion: ((String) -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = FlowCViewController()
        rootViewController.coordinator = self
        router.push(viewController: rootViewController, animated: true, origin: self)
    }
    
    func goToC2() {
        let viewController = FlowC2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: nil)
    }
    
    func finishFlow() {
        completion?("C")
        router.pop(animated: false)
        router.pop(animated: true)
    }
    
}
