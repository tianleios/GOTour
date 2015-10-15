//
//  SelectTopBut.m
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "SelectTopBut.h"
#import "ReferrerModel.h"

@implementation SelectTopBut

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.frame = CGRectMake(0, 0, kScreenWidth, tabBarHeight);
        
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, tabBarHeight - 2*kMargin, tabBarHeight - 2*kMargin)];
        [self addSubview:_iconView];
//        _iconView.backgroundColor = [UIColor cyanColor];
       
        CGFloat iconX = CGRectGetMaxX(_iconView.frame);
        CGFloat width = kScreenWidth - tabBarHeight;
        
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(iconX + kMargin, kMargin, width, 20)];
        _userName.font = [UIFont systemFontOfSize:17];

        [self addSubview:_userName];
        
        CGFloat userY = CGRectGetMaxY(_userName.frame);
        _intro = [[UILabel alloc]initWithFrame:CGRectMake(iconX + kMargin, userY,width, 20)];
        _intro.font = [UIFont systemFontOfSize:12];
        [self addSubview:_intro];
    }
    return self;
}

-(void)setReferrerModel:(ReferrerModel *)referrerModel
{
    _referrerModel = referrerModel;
    
    self.iconName = referrerModel.photo_url;
    
    _userName.text = referrerModel.username;
 
    
    _intro.text = referrerModel.intro;
 

}
-(void)setIconName:(NSString *)iconName
{
    NSURL *url = [NSURL URLWithString:iconName];
    [_iconView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = (tabBarHeight-2*kMargin) /2;
    
}

@end
