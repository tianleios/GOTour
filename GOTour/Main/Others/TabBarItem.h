//
//  TabBarItem.h
//  旅行
//
//  Created by 磊 田 on 15/9/12.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : UIControl

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lable;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@end
