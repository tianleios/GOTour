//
//  MainTabBarController.h
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLTabBarItem;
@interface MainTabBarController : UITabBarController

@property (nonatomic, strong) UIView *tabBarView;

+(instancetype)shareController;

@end
