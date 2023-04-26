//
//  TabBar.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

final class AppTabBarController: UITabBarController {
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.tabBar.tintColor = .eyes
        self.tabBar.unselectedItemTintColor = .lightGray
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var layerHeight = CGFloat()
   
    
    func customTabBar() {
        let layer = CAShapeLayer()
        let x: CGFloat = 10
        let y: CGFloat = 30
        let width = self.tabBar.bounds.width - x * 2
        let height = self.tabBar.bounds.height + y * 1.5
        layerHeight = height
        layer.fillColor = UIColor.earlGrey.cgColor
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                      y: 0,
                                                      width: self.view.bounds.width,
                                                      height: 93),
                                  cornerRadius: 10).cgPath
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBar.tintColor = .gray
        self.tabBar.itemPositioning = .automatic
        self.tabBar.unselectedItemTintColor = .lightGray
        
    }
}
