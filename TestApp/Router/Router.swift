//
//  Router.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 18/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

typealias FlowDestructionClosure = (() -> Void)
typealias MemoryAddress = String

protocol Router: class {
    var navigationController: UINavigationController { get set }
    var destructionClosures: [MemoryAddress: FlowDestructionClosure] { get set }
    
    func push(viewController: UIViewController, animated: Bool, origin: Coordinator?)
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func present(viewController: UIViewController, animated: Bool, origin: Coordinator?)
    func dismiss(animated: Bool)
}

class RouterImp: NSObject, Router {
    var navigationController: UINavigationController
    var destructionClosures: [String: FlowDestructionClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        push(viewController: viewController, animated: animated, origin: nil)
    }
    
    func push(viewController: UIViewController, animated: Bool, origin: Coordinator? = nil) {
        navigationController.activeNavigationController.pushViewController(viewController, animated: animated)
        guard let destructionClosure = origin?.destructionClosure else { return }
        destructionClosures.updateValue(destructionClosure, forKey: key(from: viewController))
    }
    
    func pop(animated: Bool) {
        navigationController.activeNavigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.activeNavigationController.popToRootViewController(animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, origin: Coordinator?) {
        if viewController is UINavigationController {
            let childNavigationController = viewController as! UINavigationController
            childNavigationController.delegate = self
            navigationController.addChildNavigationController(childNavigationController)
        }
        
        navigationController.present(viewController, animated: animated)
        viewController.presentationController?.delegate = self
        guard let destructionClosure = origin?.destructionClosure else { return }
        destructionClosures.updateValue(destructionClosure, forKey: key(from: viewController))
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
        guard let topViewController = navigationController.topViewController else { return }
        navigationController.delegate?.navigationController?(navigationController, didShow: topViewController, animated: animated)
    }
    
    func executeClosure(viewController: UIViewController) {
        guard let destructionClosure = destructionClosures.removeValue(forKey: key(from: viewController)) else { return }
        if viewController is UINavigationController {
            navigationController.removeChild(navigationController: viewController)
        }
        destructionClosure()
    }
    
    private func key(from viewController: UIViewController) -> String {
        return viewController.memoryAddress
    }
    
}

extension RouterImp: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let previousViewController = navigationController.activeNavigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if previousViewController is UINavigationController {
            guard let rootViewController = (previousViewController as! UINavigationController).viewControllers.first,
                !navigationController.viewControllers.contains(rootViewController) else { return }
        } else {
            guard !navigationController.activeNavigationController.viewControllers.contains(previousViewController) else { return }
        }
            
        executeClosure(viewController: previousViewController)
    }
    
}

extension RouterImp: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(viewController: presentationController.presentedViewController)
    }
    
}

fileprivate struct Keys {
    static var childNavigationControllers: String = "childNavigationControllers"
}

extension UINavigationController {
    
    private var childNavigationControllers: [UINavigationController]? {
        get {
            return objc_getAssociatedObject(self, &Keys.childNavigationControllers) as? [UINavigationController]
        }
        set {
            objc_setAssociatedObject(self, &Keys.childNavigationControllers, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Returns the last added navigation controller in the stack
    var activeNavigationController: UINavigationController {
        return childNavigationControllers?.last ?? self
    }
    
    func addChildNavigationController(_ navigationController: UINavigationController) {
        if childNavigationControllers == nil {
            childNavigationControllers = []
        }
        
        childNavigationControllers?.append(navigationController)
    }
    
    func removeChild(navigationController: UIViewController) {
        childNavigationControllers?.removeAll(where: { $0 === navigationController })
    }
}
