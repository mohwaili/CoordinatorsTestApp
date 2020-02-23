//
//  ViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowAViewController: UIViewController {
    
    var coordinator: FlowACoordinator?
    
    private lazy var goToA2Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To A2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToA2Button(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            goToA2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToA2Button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.title = "A1"
    }
    
    @objc func goToA2Button(_ sender: Any) {
        coordinator?.goToA2()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
