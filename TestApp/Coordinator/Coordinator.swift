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
    
    private func hold(child: Coordinator) {
        if childCoordinators == nil { childCoordinators = [] }
        print("Holding: [\(String(describing: type(of: child)))] in [\(Self.self)]")
        childCoordinators?.append(child)
    }
    
    private func release(child: Coordinator?) {
        guard let child = child else { return }
        print("Releasing: [\(String(describing: type(of: child)))] from [\(Self.self)]")
        childCoordinators = childCoordinators?.filter { $0 !== child }
    }
    
    @discardableResult
    func prepare(child: Coordinator) -> Coordinator {
        child.isCompleted = { [weak self, weak child] in
            self?.release(child: child)
        }
        hold(child: child)
        return child
    }
    
    func debug() {
        var indentation = 0
        printChildren(of: self, indentation: &indentation)
        print("\n")
    }
    
    private func tabs(multipliedBy number: Int) -> String {
        var tabs = ""
        for _ in 0..<number {
            tabs += "---"
        }
        return tabs
    }
    
    private func printChildren(of coordinator: Coordinator, indentation: inout Int) {
        print("\(tabs(multipliedBy: indentation))\(coordinator)")
        indentation += 1
        guard let children = coordinator.childCoordinators else { return }
        for child in children {
            printChildren(of: child, indentation: &indentation)
        }
        indentation -= 1
    }
    
}
