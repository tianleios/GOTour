//
//  ThemeNextTVC.h
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"
@interface ThemeNextTVC : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *name;


@end
