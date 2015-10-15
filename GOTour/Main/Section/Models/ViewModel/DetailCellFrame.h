//
//  DetailCellFrame.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDetailTextFont  [UIFont systemFontOfSize:13]
@class DetailModel;
@interface DetailCellFrame : NSObject

@property (nonatomic, strong) DetailModel *detailM;

@property (nonatomic, assign) CGRect headFrame;//标题
@property (nonatomic, assign) CGRect textFrame;//介绍
@property (nonatomic, assign) CGRect imageFrame;//图片

@property (nonatomic, assign) CGRect nextImageFrame;//可点击的详情页面

@property (nonatomic, assign) CGFloat rowHeight;

@end
