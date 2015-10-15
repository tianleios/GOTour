//
//  CellAssessoryBut.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellAccessoryBlock)(void);

@interface CellAssessoryBut : UIButton

@property (nonatomic, copy) CellAccessoryBlock block;

- (instancetype)initWithFrame:(CGRect)frame withType:(BOOL)flag;

@end
