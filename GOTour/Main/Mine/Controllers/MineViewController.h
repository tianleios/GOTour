//
//  MineViewController.h
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//  其他控制器 跳转是使用 容错

#import <UIKit/UIKit.h>
#import "ReferrerModel.h"
@interface MineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) ReferrerModel *referrer;
@property (nonatomic, assign) BOOL isUser;

@end
