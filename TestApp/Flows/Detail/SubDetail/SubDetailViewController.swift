//
//  SubDetailViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 19/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class SubDetailViewController: UIViewController {
    
    weak var coordinator: SubDetailCoordinator?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close Me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var subFlowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Sub Flow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(subFlowTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            subFlowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subFlowButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
        ])
        
        view.backgroundColor = .white
    }
    
    @objc func buttonTapped(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    @objc func subFlowTapped(_ sender: Any) {
        coordinator?.openSubFlow()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
