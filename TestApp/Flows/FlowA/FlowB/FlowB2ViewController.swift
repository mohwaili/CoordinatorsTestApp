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
        
        view.backgroundColor = .cyan
    }
    
    @objc func buttonTapped(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    @objc func startFlowC(_ sender: Any) {
        coordinator?.startFlowC()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
