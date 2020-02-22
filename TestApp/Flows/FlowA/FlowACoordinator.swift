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
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = FlowAViewController()
        rootViewController?.coordinator = self
        router.push(viewController: rootViewController!, animated: true, origin: self)
    }
    
    func startFlowB() {
        let coordinator = FlowBCoordinator(router: router)
        prepare(child: coordinator).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
