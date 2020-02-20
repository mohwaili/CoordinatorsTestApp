//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
@testable import TestApp

class CoordinatorsTests: XCTestCase {
    
    var router: Router!
    var mainCoordinator: FakeMainCoordinator!
    
    override func setUp() {
        router = RouterImp(navigationController: UINavigationController())
        mainCoordinator = FakeMainCoordinator(router: router)
    }
    
    func testStartingMainCoordinator() {
        mainCoordinator.start()
        XCTAssert(router.navigationController.topViewController is FakeMainViewController)
    }
    
    func testStartingSubCoordinator() {
        mainCoordinator.start()
        
        let detailCoordinator = FakeDetailCoordinator(router: router)
        mainCoordinator.add(child: detailCoordinator)
        detailCoordinator.start()
        
        XCTAssert(router.navigationController.viewControllers[0] is FakeMainViewController)
        XCTAssert(router.navigationController.viewControllers[1] is FakeDetailViewController)
    }
    
    func testEndingSubCoordinator() {
        mainCoordinator.start()
        
        let detailCoordinator = FakeDetailCoordinator(router: router)
        mainCoordinator.add(child: detailCoordinator)
        detailCoordinator.start()
        
        XCTAssert(router.navigationController.viewControllers[0] is FakeMainViewController)
        XCTAssert(router.navigationController.viewControllers[1] is FakeDetailViewController)
        
        router.navigationController.viewControllers[1].navigationController?.popViewController(animated: false)
        
        XCTAssert(router.navigationController.viewControllers[0] is FakeMainViewController)
        print(router.navigationController.viewControllers)
        XCTAssertTrue(router.navigationController.viewControllers.count == 1)
    }
    
    func testStoringCoordinatorReferences() {
        mainCoordinator.start()
        
        let detailCoordinator = FakeDetailCoordinator(router: router)
        mainCoordinator.add(child: detailCoordinator)
        detailCoordinator.start()
        
        XCTAssert(router.navigationController.viewControllers[0] is FakeMainViewController)
        XCTAssert(router.navigationController.viewControllers[1] is FakeDetailViewController)
        
        XCTAssert(mainCoordinator.childCoordinators?.count == 1)
    }
    
    func testRemovingCoordinatorReferences() {
        mainCoordinator.start()
        
        let detailCoordinator = FakeDetailCoordinator(router: router)
        detailCoordinator.isCompleted = {
            self.mainCoordinator.remove(child: detailCoordinator)
        }
        mainCoordinator.add(child: detailCoordinator)
        detailCoordinator.start()
        
        XCTAssert(router.navigationController.viewControllers[0] is FakeMainViewController)
        XCTAssert(router.navigationController.viewControllers[1] is FakeDetailViewController)
        
        router.pop(animated: false)
        // This is called automatically when app is running
        // This is needed in test because the transitionCoordinator
        // Is not set when running XCTest.. Thus, it'll not call the
        // completion block
        detailCoordinator.isCompleted?()
        
        XCTAssert(mainCoordinator.childCoordinators?.count == 0)
    }
    
}

class FakeCoordinator: Coordinator {
    
    let router: Router
    
    required init(router: Router) {
        self.router = router
    }
    
    func start() {
        XCTFail("should be implemented by subclass")
    }
    
}

class FakeViewController: UIViewController {
    var coordinator: Coordinator?
}

// Main
class FakeMainViewController: FakeViewController {}
class FakeMainCoordinator: FakeCoordinator {
    override func start() {
        let viewController = FakeMainViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: false, onBackClosure: isCompleted)
    }
}

// Detail
class FakeDetailViewController: FakeViewController { }
class FakeDetailCoordinator: FakeCoordinator {
    override func start() {
        let viewController = FakeDetailViewController()
        viewController.coordinator = self
        router.push(viewController: viewController, animated: false, onBackClosure: isCompleted)
    }
}
