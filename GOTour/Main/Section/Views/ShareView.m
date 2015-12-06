//
//  ShareView.m
//  GOTour
//
//  Created by 磊 田 on 15/10/18.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setContent];
        
    }
    return self;
}

- (void)setContent
{
//    UMS_qq_on@2x.png
//    UMS_qzone_icon@2x.png
//    UMS_renren_icon@2x.png
//    UMS_sina_icon@2x.png
//    UMS_sms_icon@2x.png
//    UMS_yixin_session@2x.png
//    UMS_sms_icon@2x.png
    
    NSArray *imageArray = @[@"UMS_qq_icon@2x.png",@"UMS_qzone_icon@2x.png",@"UMS_renren_icon@2x.png",@"UMS_sina_icon@2x.png",@"UMS_sms_icon@2x.png"];
    
    CGFloat w = kScreenWidth/4;

    for (int i = 0; i < 4; i++) {
        
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(w*i, 0, w, w)];
        but.contentMode = UIViewContentModeScaleToFill;
        [but setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [self addSubview:but];
    }
    for (int i = 0; i < imageArray.count - 4; i ++) {
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(w*i, w, w, w)];
        [but setImage:[UIImage imageNamed:imageArray[i + 4]] forState:UIControlStateNormal];
        [self addSubview:but];
    }

    
}

@end
