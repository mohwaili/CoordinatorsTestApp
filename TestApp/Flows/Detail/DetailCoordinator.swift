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
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = DetailViewController()
        rootViewController?.coordinator = self
        router.push(viewController: rootViewController!, animated: true, origin: self)
    }
    
    func openSubFlow() {
        let coordinator = SubDetailCoordinator(router: router)
        prepare(child: coordinator).start()
    }
    
    func finishFlow() {
        router.pop(animated: true)
    }
    
}
