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
    var isCompleted: (() -> Void)?
    let router: Router
    var rootViewController: SubDetailViewController?
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        rootViewController = SubDetailViewController()
        rootViewController?.coordinator = self
        router.present(viewController: rootViewController!, animated: true, completion: isCompleted) //origin: self)
    }
    
    func finishFlow() {
        router.dismiss(animated: true)
    }
    
}
