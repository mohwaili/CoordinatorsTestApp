//
//  SubDetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class SubDetailCoordinator: Coordinator {
    let router: Router
    var rootViewController: UINavigationController!
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let subDetailViewController = SubDetailViewController()
        rootViewController = UINavigationController(rootViewController: subDetailViewController)
        subDetailViewController.coordinator = self
        router.present(viewController: rootViewController, animated: true, origin: self)
    }
    
    func finishFlow() {
        router.dismiss(animated: true)
    }
    
    func openSubFlow() {
        prepare(child: SubSubFlowCoordinator(router: router)).start()
    }
    
}
