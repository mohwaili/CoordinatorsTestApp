//
//  SubDetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class FlowBCoordinator: Coordinator {
    let router: Router
    var rootViewController: UINavigationController!
    var completion: ((String) -> Void)?
    
    var receivedDataHandler: ((String) -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let flowBViewController = FlowBViewController()
        rootViewController = UINavigationController(rootViewController: flowBViewController)
        flowBViewController.coordinator = self
        router.present(viewController: rootViewController, animated: true, origin: self)
}
    
    func finishFlow() {
        completion?("B")
        router.dismiss(animated: true)
    }
    
    func goToB2() {
        let viewController = FlowB2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: nil)
    }
    
    func startFlowC() {
        let coordinator = FlowCCoordinator(router: router)
        coordinator.completion = receivedDataHandler
        prepare(child: coordinator).start()
    }
    
}
