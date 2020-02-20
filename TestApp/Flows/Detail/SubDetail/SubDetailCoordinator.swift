//
//  SubDetailCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class SubDetailCoordinator: Coordinator {

    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = SubDetailViewController()
        viewController.coordinator = self
        router.present(viewController: viewController, animated: true, dismissClosure: isCompleted)
    }
    
    func finishFlow() {
        router.dismiss(animated: true)
    }
    
}
