//
//  TLScrollVIew.h
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainCollectionModel;
@interface TLScrollVIew : UIScrollView


@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSArray *URLArray;

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *subTitleArray;

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, assign) NSInteger last;


@property (nonatomic, strong) MainCollectionModel *mainCollectionModel;

//+(instancetype)createTLScrollViewWithFrame:(CGRect)frame infoArray:(NSArray *)array;

@end
