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
    var flowA2ViewController: FlowA2ViewController?
    var data: String? = nil {
        didSet {
            flowA2ViewController?.data = data
        }
    }
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = FlowAViewController()
        rootViewController?.coordinator = self
        router.push(viewController: rootViewController!, animated: true, origin: self)
    }
    
    func goToA2() {
        flowA2ViewController = FlowA2ViewController()
        flowA2ViewController!.coordinator = self
        router.push(viewController: flowA2ViewController!, animated: true, origin: nil)
    }
    
    func goToA3() {
        let flowA3ViewController = FlowA3ViewController()
        flowA3ViewController.coordinator = self
        router.push(viewController: flowA3ViewController, animated: true, origin: nil)
    }
    
    func startFlowB() {
        let coordinator = FlowBCoordinator(router: router)
        coordinator.completion = { [weak self] data in
            self?.data = data
        }
        prepare(child: coordinator).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
