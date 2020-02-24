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
    var completion: ((String) -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = FlowCViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: self)
    }
    
    func goToC2() {
        let viewController = FlowC2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true)
    }
    
    func finishFlow() {
        completion?("C")
        router.pop(animated: false)
        router.pop(animated: true)
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
