//
//  collectionCell2Frame.h
//  旅行
//
//  Created by 磊 田 on 15/10/1.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFont2 [UIFont systemFontOfSize:14]
@class SelectModel;
@interface collectionCell2Frame : NSObject

@property (nonatomic, strong) SelectModel *selectM;


@property (nonatomic, assign) CGRect imageVFrame;//图片

@property (nonatomic, assign) CGRect shortDeseLblFrame;//简介

@property (nonatomic, assign) CGRect titleLblFrame;

@property (nonatomic, assign) CGRect subTitleFrame;

@property (nonatomic, assign) CGRect whereWhenFrame;

//cell 的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
