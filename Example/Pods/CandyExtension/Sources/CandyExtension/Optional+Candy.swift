//
//  OptionalExtension.swift
//  JSExtensions
//
//  Created by jesse on 2017/10/18.
//

import Foundation

// MARK: - Properties

extension Optional where Wrapped == Int {
    public func unwrapped() -> Wrapped {
        return self ?? 0
    }
}

extension Optional where Wrapped == CGFloat {
    public func unwrapped() -> Wrapped {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Float {
    public func unwrapped() -> Wrapped {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Double {
    public func unwrapped() -> Wrapped {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == String {
    public func unwrapped() -> Wrapped {
        return self ?? ""
    }
}

// MARK: - Methods

extension Optional {
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}


