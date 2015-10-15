//
//  Common.h
//  旅行
//
//  Created by 磊 田 on 15/9/18.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#ifndef ___Common_h
#define ___Common_h

#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "TLHTTPTool.h"
#import "MJRefresh.h"
#import "UIView+Frame.h"
//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define tabBarHeight 49.0
#define bigImageHeight 240

#define kMargin 5

//#define kLikeNotification
#define TLRandomColor [UIColor colorWithRed:random()%256/255 green:random()%256/255  blue:random()%256/255  alpha:1]

#endif
