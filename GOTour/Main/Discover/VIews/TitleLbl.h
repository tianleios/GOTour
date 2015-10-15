//
//  TitleLbl.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleLbl : UILabel

@property(nonatomic, copy) NSString *title;

+(instancetype)createLblWithFrame:(CGRect)frame title:(NSString *)title;
@end
