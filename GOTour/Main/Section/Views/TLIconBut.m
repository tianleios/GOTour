//
//  TLIconBut.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLIconBut.h"
#import "LikeUserModel.h"
@implementation TLIconBut

+(instancetype)createIconButWithModel:(LikeUserModel *)likeUser frame:(CGRect)frame
{
    TLIconBut *but = [[TLIconBut alloc]initWithFrame:frame];
    but.likeUser = likeUser;
    
    return but;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height/2;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:iv];
        _iconImage = iv;
        
    }
    return self;
}

- (void)setLikeUser:(LikeUserModel *)likeUser
{
    _likeUser = likeUser;
    
    UIImage *image = [UIImage imageNamed:@"defaultavatar.png"];
    
    if (_likeUser.avatar != nil) {
            
    NSURL *url = [NSURL URLWithString:_likeUser.avatar ];
    [_iconImage sd_setImageWithURL:url placeholderImage:image];
    }else{
        _iconImage.image = image;
//        [self setImage:[UIImage imageNamed:@"defaultavatar.png"] forState:UIControlStateNormal];
   
    }
   
}

@end
