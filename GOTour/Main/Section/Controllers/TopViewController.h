//
//  TopViewController.h
//  旅行
//
//  Created by 磊 田 on 15/10/01.
//  Copyright (c) 2015年 tianLei. All rights reserved.
// top 10 界面的控制器

#import <UIKit/UIKit.h>

@class CollectionModel;
@interface TopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>

//传入两个参数 才能正常使用
@property (nonatomic, copy) NSString *urlStr; //顶部视图的url

@property (nonatomic, strong) CollectionModel *collectionM;//一个相关的模型

@end
