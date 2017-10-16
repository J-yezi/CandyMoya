//
//  CandyTargetType.swift
//  HttpManager
//
//  Created by jesse on 2017/9/19.
//  Copyright © 2017年 jesse. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public typealias Task = Moya.Task
public typealias Method = Moya.Method
public typealias ParameterEncoding = Moya.ParameterEncoding

public protocol CandyTargetType: TargetType {
    
    /// 完整的url地址
    var completeURL: URL { get }
    
    /// 地址+Method
    var route: CandyRoute { get }
    
    /// 默认的参数，如果后面设置了其他参数会合并到一起
    var defaultParams: [String: Any]? { get }
    
    /// 设置http的header
    var httpHeaderFields: [String: String]? { get }

    /// 设置http的默认header
    var defaultHeaderFields: [String: String]? { get }
}

public extension CandyTargetType {
    var completeURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    var path: String {
        return self.route.path
    }
    
    var method: Method {
        return self.route.method
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    var defaultParams: [String: Any]? {
        return nil
    }
    
    var httpHeaderFields: [String: String]? {
        return nil
    }

    var defaultHeaderFields: [String: String]? {
        return nil
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return Data()
    }
}
