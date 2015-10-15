//
//  LoadMoreBut.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoadMoreBlock)(void);

@interface LoadMoreBut : UIControl

@property (nonatomic, copy) LoadMoreBlock block;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *lbl;



+ (instancetype)createLoadMoreButtonWithFrame:(CGRect)frame flag:(BOOL)flag actionBlock:(LoadMoreBlock)block;
@end
