//
//  DictionaryExtension.swift
//  Pods
//
//  Created by jesse on 2017/7/22.
//
//

import Foundation

// MARK: - Methods

extension Dictionary {
    /// 是否包含了key
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// 移除所有keys中的value
    public mutating func removeAll(keys: [Key]) {
        keys.forEach { removeValue(forKey: $0) }
    }
    
    public func filter(where condition: (Key, Value) -> Bool) -> [Key: Value] {
        var result = [Key: Value]()
        forEach {
            if condition($0, $1) {
                result[$0] = $1
            }
        }
        return result
    }
    
    public func map<T, U>(condition: (Key, Value) -> [T: U]) -> [T: U] {
        var result = [T: U]()
        forEach { result += condition($0, $1) }
        return result
    }
}

//MARK: - Operators

extension Dictionary {
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach{ result[$0] = $1 }
        return result
    }

    public static func + (lhs: [Key: Value], rhs: [Key: Value]?) -> [Key: Value] {
        var result = lhs
        if let rhs = rhs {
            rhs.forEach{ result[$0] = $1 }
        }
        return result
    }
    
    public static func - (lhs: [Key: Value], keys: [Key]) -> [Key: Value]{
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }
    
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach({ lhs[$0] = $1})
    }
    
    public static func -= (lhs: inout [Key: Value], keys: [Key]) {
        lhs.removeAll(keys: keys)
    }
}
