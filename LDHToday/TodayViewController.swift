//
//  TodayViewController.swift
//  LDHToday
//
//  Created by lidehua on 15/6/11.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    let screenWidth = UIScreen.mainScreen().bounds.size.width;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width: screenWidth, height: 224);
        var dataList = NSMutableArray();
        var dataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://mapi.damai.cn/proj/HotProj.aspx")!, completionHandler: { (data, response, error) -> Void in
            var dataDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary;
            var dataArray = dataDictionary["list"] as! NSArray;
                for (index , value) in enumerate(dataArray) {
                    var dic = value as! NSDictionary;
                    var model = Model(name: dic["Name"] as? String, showTime: dic["ShowTime"] as? String, cityName: dic["cityname"] as? String);
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.view.addSubview({ (model : Model , index : Int) -> UIView in
                            var backView = UIView(frame: CGRect(x: CGFloat(0) , y: CGFloat(70 * index), width: self.screenWidth , height:CGFloat(68)));
                            backView.backgroundColor = UIColor.yellowColor();
                            var nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.screenWidth, height: 17));
                            nameLabel.text = model.name;
                            backView.addSubview(nameLabel);
                            var timeLabel = UILabel(frame: CGRect(x: 0, y: 17 + 8, width: self.screenWidth, height: 17));
                            timeLabel.text = model.showTime;
                            backView.addSubview(timeLabel);
                            var cityLabel = UILabel(frame: CGRect(x: 0, y: 17 * 2 + 8 * 2, width: self.screenWidth, height: 17));
                            cityLabel.text = model.cityName;
                            backView.addSubview(cityLabel);
                            return backView;
                            } (model , index));
                    })
                    if index == 2 {
                        break;
                    }
                }
        });
        dataTask.resume();
    }
//    func createViewWithModel(model:Model) -> UIView? {
//        var backView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 68));
//        var nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 17));
//        backView.addSubview(nameLabel);
//        var timeLabel = UILabel(frame: CGRect(x: 0, y: 17 + 8, width: screenWidth, height: 17));
//        backView.addSubview(timeLabel);
//        var cityLabel = UILabel(frame: CGRect(x: 0, y: 17 * 2 + 8 * 2, width: screenWidth, height: 17));
//        backView.addSubview(cityLabel);
//        return backView;
//    }
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero;
    }
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
