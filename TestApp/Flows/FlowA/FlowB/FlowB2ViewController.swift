//
//  SubDetailViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class FlowB2ViewController: UIViewController {
    
    weak var coordinator: FlowBCoordinator?
    
    var data: String? = nil {
        didSet {
            finishFlowButton.isEnabled = true
            finishFlowButton.backgroundColor = .green
        }
    }
    
    private lazy var finishFlowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finish Flow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(finishFlowTapped(_:)), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = .red
        view.addSubview(button)
        return button
    }()
    
    private lazy var startFlowC: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start C Flow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startFlowC(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "B2"
        
        NSLayoutConstraint.activate([
            startFlowC.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startFlowC.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            finishFlowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishFlowButton.topAnchor.constraint(equalTo: startFlowC.bottomAnchor, constant: 10)
        ])
        
        coordinator?.receivedDataHandler = { [weak self] data in
            self?.data = data
        }
        
        view.backgroundColor = .cyan
    }
    
    @objc func finishFlowTapped(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    @objc func startFlowC(_ sender: Any) {
        coordinator?.startFlowC()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
