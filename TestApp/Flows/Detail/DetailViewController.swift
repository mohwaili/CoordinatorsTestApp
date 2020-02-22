//
//  ViewController.swift
//  TestApp
//
//  Created by Mohammed Al Waili on 17/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    weak var coordinator: DetailCoordinator?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(removeMe(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var subFlowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open SubFlow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(openSubFlow(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subFlowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subFlowButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func removeMe(_ sender: Any) {
        coordinator?.finishFlow()
    }
    
    @objc func openSubFlow(_ sender: Any) {
        coordinator?.openSubFlow()
    }
    
    deinit {
        print("deallocating: \(Self.self)")
    }
    
}
