//
//  SelectTopBut.h
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReferrerModel;
@interface SelectTopBut : UIControl

@property(nonatomic, copy) NSString *iconName;

@property(nonatomic, strong) UIImageView *iconView;

@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *intro;

@property(nonatomic, strong) ReferrerModel *referrerModel;



@end
