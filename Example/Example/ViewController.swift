//
//  ViewController.swift
//  Example
//
//  Created by jesse on 2017/9/20.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit
import CandyMoya
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown

        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        view.addGestureRecognizer(tap)

        Thread.main.name = "Main Thread"
    }

    @objc func click() {
        RxProvider.request(target: .orders(currentPage: 0, perPage: 10000, headers: ["UUID": "123333"]))
            .mapSwiftyJSON(keyPath: "data.orders")
            .subscribe(onNext: {
                print("next: \(String(describing: Thread.current.name)) -> \($0)")
            }, onError: {
                print($0)
            }).disposed(by: disposeBag)
    }
}

extension ObservableType {
    public func subscribe(onNext: ((Self.E) -> Swift.Void)? = nil) -> Disposable {
        return subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}

