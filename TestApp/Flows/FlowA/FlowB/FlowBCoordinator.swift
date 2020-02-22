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
        router.dismiss(animated: true)
    }
    
    func startFlowC() {
        prepare(child: FlowCCoordinator(router: router)).start()
    }
    
}
