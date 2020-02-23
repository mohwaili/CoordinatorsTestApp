//
//  SubDetailViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowBViewController: UIViewController {
    
    var coordinator: FlowBCoordinator?
    
    private lazy var goToB2Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To B2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(goToB2(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "B1"
        
        NSLayoutConstraint.activate([
            goToB2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToB2Button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.backgroundColor = .cyan
    }
    
    @objc func goToB2(_ sender: Any) {
        coordinator?.goToB2()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
