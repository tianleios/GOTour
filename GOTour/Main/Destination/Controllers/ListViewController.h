//
//  ListViewController.h
//  旅行
//
//  Created by 磊 田 on 15/10/9.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstDestionModel.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) FirstDestionModel *firstM;
@property (nonatomic, strong) NSNumber *ID;
@end
