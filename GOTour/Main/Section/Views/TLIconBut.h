//
//  TLIconBut.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LikeUserModel;
#import "ReferrerModel.h"
@interface TLIconBut : UIControl

@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, assign) NSInteger *userID;

@property (nonatomic, strong) LikeUserModel *likeUser;

//@property (nonatomic, strong) LikeUserModel *likeUser;

+(instancetype)createIconButWithModel:(LikeUserModel *)likeUser frame:(CGRect)frame;

@end
