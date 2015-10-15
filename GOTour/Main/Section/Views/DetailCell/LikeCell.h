//
//  LikeCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTextBut.h"

typedef void(^MoreBlock)(void);

@interface LikeCell : UITableViewCell

@property (nonatomic, strong) NSArray *likeUserArray;

@property (nonatomic, weak) ImageTextBut *likeBut;

@property (nonatomic, weak) UIButton *moreBut;

@property (nonatomic, copy) MoreBlock moreBlock;

+ (instancetype)createLikeCellWithLikeUser:(NSArray *)array;
@end
