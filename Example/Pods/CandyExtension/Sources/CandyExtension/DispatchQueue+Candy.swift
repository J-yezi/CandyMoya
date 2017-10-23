//
//  DispatchQueueExtension.swift
//  Pods
//
//  Created by jesse on 2017/6/24.
//
//

import Foundation

extension DispatchQueue {
    public func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
