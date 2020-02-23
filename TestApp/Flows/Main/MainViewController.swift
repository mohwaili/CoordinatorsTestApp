//
//  ViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Flow A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(startFlowA(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.title = "Main"
    }
    
    @objc func startFlowA(_ sender: Any) {
        coordinator?.startFlowA()
    }
    
}

