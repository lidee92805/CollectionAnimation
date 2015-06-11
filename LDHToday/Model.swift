//
//  Model.swift
//  CollectionAnimation
//
//  Created by lidehua on 15/6/11.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

import Foundation

class Model: NSObject {
    var name : String;
    var showTime : String;
    var cityName : String;
    init(name : String? , showTime : String? , cityName : String?) {
        self.name = name!;
        self.showTime = showTime!;
        self.cityName = cityName!;
    }
}
