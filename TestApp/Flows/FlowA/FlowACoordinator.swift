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
    var rootViewController: FlowAViewController?
    var receivedDataHandler: ((String) -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = FlowAViewController()
        rootViewController?.coordinator = self
        router.push(viewController: rootViewController!, animated: true, origin: self)
    }
    
    func goToA2() {
        let viewController = FlowA2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: nil)
    }
    
    func goToA3() {
        let flowA3ViewController = FlowA3ViewController()
        flowA3ViewController.coordinator = self
        router.push(viewController: flowA3ViewController, animated: true, origin: nil)
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
