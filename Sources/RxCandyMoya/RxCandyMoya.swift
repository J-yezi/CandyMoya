//
//  RxCandyProvider.swift
//  HttpManager
//
//  Created by jesse on 2017/9/19.
//  Copyright © 2017年 jesse. All rights reserved.
//

import Moya

public class RxCandyMoyaProvider<Target: CandyTarget>: RxMoyaProvider<Target> {
    public convenience init(timeout: TimeInterval) {
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
            var headerFields = target.httpHeaderFields
            if let defaultHeaderFields = target.defaultHeaderFields {
                headerFields = defaultHeaderFields + headerFields
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
