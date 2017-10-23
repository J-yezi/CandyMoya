//
//  UIScreenExtension.swift
//  Extension
//
//  Created by jesse on 2017/6/9.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit

// MARK: - Properties

extension UIScreen {
    public var screenSize: CGSize {
        return (UIScreen.main.currentMode?.size)!
    }
    
    public var isSize_3_5: Bool {
        return self.screenSize == CGSize(width: 320, height: 480)
    }
    
    public var isSize_4_0: Bool {
        return self.screenSize == CGSize(width: 320, height: 568)
    }
    
    public var isSize_4_7: Bool {
        return self.screenSize == CGSize(width: 375, height: 667)
    }
    
    public var isSize_5_5: Bool {
        return self.screenSize == CGSize(width: 621, height: 1104)
    }
    
    public var isIPadAir2: Bool {
        return self.screenSize == CGSize(width: 768, height: 1024)
    }
    
    public var isIPadPro: Bool {
        return self.screenSize == CGSize(width: 1024, height: 1366)
    }
}
