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
    
    var data: String? = nil {
        didSet {
            button.isEnabled = true
            button.backgroundColor = .green
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finish Flow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = .red
        view.addSubview(button)
        return button
    }()
    
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
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            goToB2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToB2Button.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
        ])
        
        view.backgroundColor = .cyan
    }
    
    @objc func buttonTapped(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    @objc func goToB2(_ sender: Any) {
        coordinator?.goToB2()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
