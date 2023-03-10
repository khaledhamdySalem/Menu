//
//  ContainerViewController.swift
//  Menu
//
//  Created by KH on 10/03/2023.
//

import UIKit

class ContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Enum
    enum MenuState {
        case opened
        case closed
    }
    
    // MARK: - Properties
    let homeVC = HomeViewController()
    let menuVC = MenuViewController()
    var menueState: MenuState = .closed
    var navVC: UINavigationController?
    
    lazy var infoVc = InfoViewController()
    lazy var shareVC = ShareViewController()
    lazy var settingVC = SettingViewController()
    lazy var ratingVC = AppRatingViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addChild()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Add Child Controller
    private func addChild() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.delegate = self
        menuVC.didMove(toParent: self)
        
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        homeVC.delegate = self
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}
// MARK: - Extension Home Delegate
extension ContainerViewController: HomeViewControllerDelegate {
    
    func didTapMenu() {
        switch menueState {
        case .closed:
            handleMenuAction(value: self.homeVC.view.frame.size.width - 100, state: .opened, complition: nil)
        case .opened:
            handleMenuAction(value: 0, state: .closed, complition: nil)
        }
    }
    
    private func handleMenuAction(value: CGFloat, state: MenuState, complition: (() -> ())?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.navVC?.view.frame.origin.x = value
        } completion: { done in
            if done {
                self.menueState = state
                DispatchQueue.main.async {
                    complition?()
                }
            }
        }
    }
}

// MARK: - Select From Menu
extension ContainerViewController: MenuControllerDelegate {
    func didSelectFromMenu(_ menu: MenuViewController.menuOptions) {
        
        handleMenuAction(value: 0, state: .closed, complition: nil)
        switch menu {
        case .home:
            resetToHome([infoVc, shareVC, settingVC, ratingVC])
        case .info:
            addController(infoVc)
        case .appRating:
            addController(ratingVC)
        case .shareApp:
            addController(shareVC)
        case .setting:
            addController(settingVC)
        }
    }
    
    func addController(_ vc: UIViewController) {
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = homeVC.view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome(_ vc: [UIViewController]) {
        vc.forEach { vc in
            vc.view.removeFromSuperview()
            vc.didMove(toParent: nil)
            homeVC.title = "Home"
        }
    }
}
