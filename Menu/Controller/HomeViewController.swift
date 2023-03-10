//
//  HomeViewController.swift
//  Menu
//
//  Created by KH on 10/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Delegate
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addNavigationItem()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Home"
    }
    
    private func addNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(handleMenuTap))
    }
    
    @objc private func handleMenuTap() {
        delegate?.didTapMenu()
    }
}


protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenu()
}
