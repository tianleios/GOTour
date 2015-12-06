//
//  NavigationBarVIew.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SaveLikeBlock)(void);
typedef void(^DeleteLikeBlock)(void);
typedef void(^ShareBlock)(void);


@interface NavigationBarVIew : UIView

@property (nonatomic, copy) SaveLikeBlock saveBlock;
@property (nonatomic, copy) DeleteLikeBlock deleteBlock;
@property (nonatomic, copy) ShareBlock shareBlock;


@property (nonatomic, weak) UIButton *likeBut;

+ (instancetype)createNavigationBar:(CGRect)frame save:(SaveLikeBlock)save delete:(DeleteLikeBlock)delete share:(ShareBlock)share;

@end
