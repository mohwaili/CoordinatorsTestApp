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
    var cData: String? = nil {
        didSet {
            if let bViewController = self.rootViewController.viewControllers.first as? FlowBViewController {
                bViewController.data = cData
            }
        }
    }
    
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
        completion?("B\(cData ?? "")")
        router.dismiss(animated: true)
    }
    
    func goToB2() {
        let viewController = FlowB2ViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: self)
    }
    
    func startFlowC() {
        let coordinator = FlowCCoordinator(router: router)
        coordinator.completion = { [weak self] data in
            self?.cData = data
        }
        prepare(child: coordinator).start()
    }
    
}
