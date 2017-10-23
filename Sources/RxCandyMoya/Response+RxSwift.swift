//
//  Response+RxSwift.swift
//  CandyMoya
//
//  Created by jesse on 2017/10/23.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import SwiftyJSON

extension ObservableType where E == Response {
    public func mapObject<T: BaseMappable>(_ type: T.Type, keyPath: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self, keyPath: keyPath))
        }
    }

    public func mapArray<T: BaseMappable>(_ type: T.Type, keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self, keyPath: keyPath))
        }
    }

    public func mapSwiftyJSON(keyPath: String? = nil) -> Observable<JSON> {
        return flatMap { response -> Observable<JSON> in
            let temp: Any
            if let keyPath = keyPath {
                temp = (try response.mapJSON() as AnyObject).value(forKeyPath: keyPath) as Any
            }else {
                temp = try response.mapJSON()
            }
            return Observable.just(JSON(temp))
        }
    }
}
