//
//  TLWhereWhenLikeVIew.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum {
//    MessageTypeMe = 0,
//    MessageTypeShe = 1
//    
//} MessageType;
//
#import "SelectModel.h"
typedef enum
{
    TLWhereLikeStyle = 0,
    TLWhereWhenStyle = 1,
    TLWhereStyle = 2,

    
}TLWhereWhenLikeStyle;

@interface TLWhereWhenLikeVIew : UIView

//- (void)createWhenWhereLikeWithLike:(NSNumber *)likeCount where:(NSString *)where whenBegin:(NSString *)timeBegin whenEnd:(NSString *)timeEnd type:(TLWhereWhenLikeStyle)style ;

//必须先设置style 在为selectMOdel 赋值

@property (nonatomic, assign) TLWhereWhenLikeStyle style;
@property (nonatomic, strong) SelectModel *selectM;

@end
