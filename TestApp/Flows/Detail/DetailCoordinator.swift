//
//  DetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {

    let router: Router
    var rootViewController: DetailViewController?
    var isCompleted: (() -> Void)?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = DetailViewController()
        rootViewController?.coordinator = self
        router.push(viewController: rootViewController!, animated: true, completion: isCompleted) //origin: self)
    }
    
    func openSubFlow() {
        let coordinator = SubDetailCoordinator(router: router)
        coordinator.isCompleted = { [weak self, weak coordinator] in
            self?.release(child: coordinator!)
        }
        hold(child: coordinator)
        coordinator.start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
