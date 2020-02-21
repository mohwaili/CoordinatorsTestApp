//
//  Coordinator.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator]? { get set }
//    var rootViewController: View? { get set }
    var router: Router { get }
    var isCompleted: (() -> Void)? { get set }
    
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
    
//    var isCompleted: (() -> Void)? {
//        get {
//            return objc_getAssociatedObject(self, &Keys.isCompletedClosureId) as? (() -> Void)
//        }
//        set {
//            objc_setAssociatedObject(self, &Keys.isCompletedClosureId, newValue, .OBJC_ASSOCIATION_COPY)
//        }
//    }
    
    func hold(child: Coordinator) {
        if childCoordinators == nil {
            childCoordinators = []
        }
        childCoordinators?.append(child)
    }
    
    func release(child: Coordinator) {
        childCoordinators = childCoordinators?.filter { $0 !== child }
        print(child)
    }
    
//    @discardableResult
//    func prepare(child: Coordinator) -> Coordinator {
//        child.isCompleted = { [weak self] in
//            self?.release(child: child)
//        }
//        hold(child: child)
//        return child
//    }
    
    func debug() {
        printChildren(of: self)
    }
    
    private func printChildren(of coordinator: Coordinator) {
        print("\(coordinator)")
        guard let children = coordinator.childCoordinators else { return }
        for child in children {
            printChildren(of: child)
        }
        print("\n")
    }
    
}
