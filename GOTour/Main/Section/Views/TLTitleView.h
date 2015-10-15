//
//  TLTitleView.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
// 用于添加标题

#import <UIKit/UIKit.h>

@interface TLTitleView : UIView

- (void)addTitle:(NSString *)title subTitle:(NSString *)subTitle topBootomScale:(CGFloat)scale titleFont:(NSInteger)font1 subTitleFont:(NSInteger)font2;
@end
