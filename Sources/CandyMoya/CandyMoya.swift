//
//  CandyProvider.swift
//  HttpManager
//
//  Created by jesse on 2017/9/19.
//  Copyright © 2017年 jesse. All rights reserved.
//

import Moya

public class CandyMoyaProvider<Target: CandyTargetType>: MoyaProvider<Target> {
    public convenience init(_ timeout: TimeInterval) {
        let manager = MoyaProvider<Target>.candyAlamofireManager(timeout: timeout)
        self.init(manager: manager)
    }
    
    public override init(
        endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false) {
        func candyEndpointClosure(target: Target) -> Endpoint<Target> {
            let endpoint = endpointClosure(target)
            /// 合并参数
            var parameters = endpoint.parameters
            if let defaultParams = target.defaultParams {
                parameters = defaultParams + parameters
            }
            /// 合并header
            var headerFields = endpoint.httpHeaderFields
            if let defaultHeaderFields = target.httpHeaderFields {
                headerFields = (defaultHeaderFields + headerFields)
            }
            return Endpoint<Target>(
                url: target.completeURL.absoluteString,
                sampleResponseClosure: endpoint.sampleResponseClosure,
                method: endpoint.method,
                parameters: parameters,
                parameterEncoding: endpoint.parameterEncoding,
                httpHeaderFields: headerFields
            )
        }
        
        /// 需要判断是否设置timeout
        super.init(
            endpointClosure: candyEndpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            manager: manager,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
}

extension MoyaProvider {
    static func candyAlamofireManager(timeout: TimeInterval) -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        /// 设置manager的超时时间
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
}

extension Dictionary where Key == String {
    static func + (lhs: [String: Value], rhs: [String: Value]?) -> [String: Value] {
        guard let rhs = rhs else { return lhs }
        
        var lhs = lhs
        rhs.forEach {
            lhs[$0.key] = $0.value
        }
        return lhs
    }
}
