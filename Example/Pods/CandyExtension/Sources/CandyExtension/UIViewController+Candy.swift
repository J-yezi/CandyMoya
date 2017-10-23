//
//  UIViewControllerExtension.swift
//  Extension
//
//  Created by jesse on 2017/5/25.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit

// MARK: - Properties

extension UIViewController {
    /// 当前controller可见
    public var isVisible: Bool {
        return self.isViewLoaded && view.window != nil
    }
    
    /// control在navigaton中的上一个control
    public var previous: UIViewController? {
        guard let navigationController = navigationController else { return nil }
        let index = navigationController.viewControllers.index(of: self)
        
        guard let i = index, i > 0 else {
            return nil
        }
        return navigationController.viewControllers[i - 1]
    }
}
