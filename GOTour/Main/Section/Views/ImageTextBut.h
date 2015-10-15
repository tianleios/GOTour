//
//  ImageTextBut.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextBut : UIControl

+(instancetype)createButWithImage:(UIImage *)image title:(NSString *)title frame:(CGRect)frame scale:(CGFloat)scale;

@property (nonatomic, copy) NSString *text;
@end
