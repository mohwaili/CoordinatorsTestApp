//
//  MainCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class MainCoordinator: Coordinator {
    var isCompleted: (() -> Void)?
    
    
    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        let mainVC = MainViewController()
        mainVC.coordinator = self
        router.push(viewController: mainVC, animated: false, completion: isCompleted)//origin: self)
    }
    
    func startDetail() {
        let detailCoordinator = DetailCoordinator(router: router)
        hold(child: detailCoordinator)
        detailCoordinator.isCompleted = { [weak self, weak detailCoordinator] in
            self?.release(child: detailCoordinator!)
        }
        detailCoordinator.start()
//        prepare(child: detailCoordinator).start()
    }
    
}
