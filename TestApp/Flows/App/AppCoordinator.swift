//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    var window: UIWindow?
    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    convenience init(window: UIWindow, router: Router) {
        self.init(router: router)
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator(router: router)
        prepare(child: mainCoordinator).start()
        
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
    }
    
}
