//
//  Coordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator]? { get set }
    var router: Router { get }
    
    init(router: Router)
    
    func start()
}

fileprivate struct Keys {
    static var childerCoordinatorsId: String = "id"
    static var isCompletedClosureId: String = "closure"
}

extension Coordinator {
    
    var childCoordinators: [Coordinator]? {
        get {
            return objc_getAssociatedObject(self, &Keys.childerCoordinatorsId) as? [Coordinator]
        }
        set {
            objc_setAssociatedObject(self, &Keys.childerCoordinatorsId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isCompleted: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &Keys.isCompletedClosureId) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &Keys.isCompletedClosureId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func hold(child: Coordinator) {
        if childCoordinators == nil {
            childCoordinators = []
        }
        childCoordinators?.append(child)
    }
    
    func release(child: Coordinator) {
        childCoordinators = childCoordinators?.filter { $0 !== child }
    }
    
}
