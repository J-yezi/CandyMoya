//
//  UIApplicationExtension.swift
//  Extension
//
//  Created by jesse on 2017/6/9.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit

private var kStatusViewKey: Void?
private var kFullViewKey: Void?

// MARK: - Properties

extension UIApplication {
    /// 获取整个应用被present道最顶部的controller，方便后面使用该controller进行present
    /// 如果UIViewController在UINavigatonController中，那么presented就是navControl，如果在UITabBarController中，那么presented就是tabbarControl
    public var presented: UIViewController? {
        if let control = UIApplication.shared.keyWindow?.rootViewController {
            while control.presentedViewController != nil && control.presentedViewController?.isBeingDismissed == false {
                return control.presentedViewController!
            }
            return control
        }
        return nil
    }

    /// 获取当前可见Controller的NavigationController，这个属性有可能获取的不准确，具体和具体的视图结构有关
    public var navControl: UINavigationController? {
        guard let presented = UIApplication.shared.presented else { return nil }
        if presented is UITabBarController {
            let tabbarControl = presented as! UITabBarController
            if let control = tabbarControl.viewControllers?[tabbarControl.selectedIndex] {
                if control is UINavigationController {
                    return control as? UINavigationController
                }
            }
            return nil
        }else if presented is UINavigationController {
            return presented as? UINavigationController
        }
        return nil
    }
    
    /// statusView.isHidden = false来打开这个遮挡状态栏的视图，默认是false
    public var statusView: UIView? {
        get {
            if let shadeView = objc_getAssociatedObject(self, &kStatusViewKey) as? UIView {
                return shadeView
            }else {
                let shadeView = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
                shadeView.windowLevel = UIWindowLevelStatusBar
                shadeView.rootViewController = UIViewController()
                self.statusView = shadeView
                return shadeView
            }
        }
        set {
            objc_setAssociatedObject(self, &kStatusViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var fullView: UIView? {
        get {
            if let shadeView = objc_getAssociatedObject(self, &kFullViewKey) as? UIView {
                return shadeView
            }else {
                let shadeView = UIWindow(frame: UIScreen.main.bounds)
                shadeView.windowLevel = UIWindowLevelStatusBar
                shadeView.rootViewController = UIViewController()
                self.fullView = shadeView
                return shadeView
            }
        }
        set {
            objc_setAssociatedObject(self, &kFullViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
