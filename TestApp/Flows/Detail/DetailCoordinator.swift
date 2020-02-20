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
        router.push(viewController: viewController, animated: true, onBackClosure: isCompleted)
    }
    
    func openSubFlow() {
        let subDetailCoordinator = SubDetailCoordinator(router: self.router)
        prepare(child: subDetailCoordinator).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
