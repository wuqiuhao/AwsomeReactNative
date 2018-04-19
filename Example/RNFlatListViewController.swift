//
//  RNFlatListViewController.swift
//  Example
//
//  Created by Hale on 2018/4/16.
//  Copyright © 2018年 Hale. All rights reserved.
//

import UIKit
import React

class RNFlatListViewController: UIViewController {
    override func loadView() {
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
        let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "FlatList", initialProperties: nil, launchOptions: nil)
        view = rootView
    }
}
