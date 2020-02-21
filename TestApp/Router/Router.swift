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
    var onBackClosures: [MemoryAddress: FlowDestructionClosure] { get set }
    
    func push(viewController: UIViewController, animated: Bool, origin: Coordinator?)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func present(viewController: UIViewController, animated: Bool, origin: Coordinator?)
    func dismiss(animated: Bool)
}


class RouterImp: NSObject, Router {
    var navigationController: UINavigationController
    var onBackClosures: [String: FlowDestructionClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func push(viewController: UIViewController, animated: Bool, origin: Coordinator?) {
        navigationController.pushViewController(viewController, animated: animated)
        guard let destructionClosure = origin?.isCompleted else { return }
        onBackClosures.updateValue(destructionClosure, forKey: key(from: viewController))
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, origin: Coordinator?) {
        navigationController.present(viewController, animated: animated)
        viewController.presentationController?.delegate = self
        guard let destructionClosure = origin?.isCompleted else { return }
        onBackClosures.updateValue(destructionClosure, forKey: key(from: viewController))
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
        guard let topViewController = navigationController.topViewController else { return }
        navigationController.delegate?.navigationController?(navigationController, didShow: topViewController, animated: animated)
    }
    
    func executeClosure(viewController: UIViewController) {
        guard let onBackClosure = onBackClosures.removeValue(forKey: key(from: viewController)) else { return }
        onBackClosure()
    }
    
    private func key(from viewController: UIViewController) -> String {
        return viewController.memoryAddress
    }
    
}

extension RouterImp: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousViewController) else { return }
        executeClosure(viewController: previousViewController)
    }
    
}

extension RouterImp: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(viewController: presentationController.presentedViewController)
    }
    
}

