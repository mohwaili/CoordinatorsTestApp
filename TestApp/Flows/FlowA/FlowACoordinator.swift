//
//  DetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class FlowACoordinator: Coordinator {

    let router: Router
    var receivedDataHandler: ((String) -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = FlowAViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: self)
    }
    
    func goToA2() {
        let viewController = FlowA2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true)
    }
    
    func goToA3() {
        let flowA3ViewController = FlowA3ViewController()
        flowA3ViewController.coordinator = self
        router.push(viewController: flowA3ViewController, animated: true)
    }
    
    func startFlowB() {
        let coordinator = FlowBCoordinator(router: router)
        coordinator.completion = receivedDataHandler
        prepare(child: coordinator).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
