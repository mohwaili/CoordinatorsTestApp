//
//  MainCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class MainCoordinator: Coordinator {
    
    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let mainVC = MainViewController()
        mainVC.coordinator = self
        router.push(viewController: mainVC, animated: false, origin: self)
    }
    
    func startDetail() {
        let detailCoordinator = DetailCoordinator(router: router)
        prepare(child: detailCoordinator).start()
    }
    
}
