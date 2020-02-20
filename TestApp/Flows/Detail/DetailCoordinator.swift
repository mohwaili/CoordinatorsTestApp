//
//  DetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class DetailCoordinator: Coordinator {
    
    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = DetailViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: true, origin: self)
    }
    
    func openSubFlow() {
        prepare(child: SubDetailCoordinator(router: router)).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
