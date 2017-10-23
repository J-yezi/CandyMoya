//
//  HttpManager.swift
//  Example
//
//  Created by jesse on 2017/10/23.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit
import CandyMoya
import RxSwift

struct RxProvider {
    static let provider = RxCandyMoyaProvider<YQJTarget>(timeout: 50)

    static func request(target: YQJTarget) -> Observable<Response> {
        return provider.request(target)
    }
}
