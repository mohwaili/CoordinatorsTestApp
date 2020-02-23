//
//  FlowA2ViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 22/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowA2ViewController: UIViewController {
    
    var coordinator: FlowACoordinator?
    
    var data: String? = nil {
        didSet {
            goToA3Button.isEnabled = true
            goToA3Button.backgroundColor = .green
        }
    }
    
    private lazy var goToA3Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To A3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToA3Button(_:)), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = .red
        return button
    }()
    
    private lazy var startFlowBButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Flow B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(startFlowB(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            goToA3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToA3Button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startFlowBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startFlowBButton.topAnchor.constraint(equalTo: goToA3Button.bottomAnchor, constant: 10)
        ])
        
        coordinator?.receivedDataHandler = { [weak self] data in
            self?.data = data
        }
        
        title = "A2"
    }
    
    @objc func goToA3Button(_ sender: Any) {
        coordinator?.goToA3()
    }
    
    @objc func startFlowB(_ sender: Any) {
        coordinator?.startFlowB()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
