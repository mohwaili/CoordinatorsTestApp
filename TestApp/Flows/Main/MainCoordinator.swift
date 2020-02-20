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
        isCompleted = { [weak self] in
            self?.startDetail()
        }
        router.push(viewController: mainVC, animated: false, onBackClosure: isCompleted)
    }
    
    func startDetail() {
        let detailCoordinator = DetailCoordinator(router: router)
        hold(child: detailCoordinator)
        detailCoordinator.isCompleted = { [weak self] in
            self?.release(child: detailCoordinator)
        }
        detailCoordinator.start()
    }
    
}
