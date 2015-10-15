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

@interface NavigationBarVIew : UIView

@property (nonatomic, copy) SaveLikeBlock saveBlock;
@property (nonatomic, copy) DeleteLikeBlock deleteBlock;


+ (instancetype)createNavigationBar:(CGRect)frame save:(SaveLikeBlock)save delete:(DeleteLikeBlock)delete;

@end
