//
//  NavigationBarVIew.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NavigationBarVIew.h"

@interface NavigationBarVIew()


@end
@implementation NavigationBarVIew
//activity_btnShare.png 白
//view_btn_back.png
//web_btn_back.png

//activity_btnUnLike.png 空心白
//activity_btnLike.png 实心红心
//activity_btnUnLike_red.png 空心红
+ (instancetype)createNavigationBar:(CGRect)frame save:(SaveLikeBlock)save delete:(DeleteLikeBlock)delete share:(ShareBlock)share
{
    NavigationBarVIew *nv = [[NavigationBarVIew alloc] initWithFrame:frame];
    nv.saveBlock = save;
    nv.deleteBlock = delete;
    nv.shareBlock =share;
    return nv;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        //返回按钮
        UIButton *backBut = [[UIButton alloc]initWithFrame:CGRectMake(15, height/2 - 20 , 40, 40)];
        
        [backBut setImage:[UIImage imageNamed:@"button_back@2x.png"] forState:UIControlStateNormal];
        [backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:backBut];
        backBut.contentMode =  UIViewContentModeScaleAspectFill;
        //收藏按钮牛
        UIButton *but = [[UIButton alloc] init];
        [self addSubview:but];
        _likeBut = but;
        _likeBut.frame = CGRectMake(width - 65, height/2 - 22.5 , 45, 45);
        
        [_likeBut setImage:[UIImage imageNamed:@"activity_btnUnLike.png"] forState:UIControlStateNormal];
        
        [_likeBut setImage:[UIImage imageNamed:@"activity_btnLike.png"] forState:UIControlStateSelected];

        [_likeBut addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //分享控件
        UIButton *shareBut = [[UIButton alloc]initWithFrame:CGRectMake(width - 115, height/2 - 20 , 40, 40)];
        [shareBut setImage:[UIImage imageNamed:@"activity_btnShare.png"] forState:UIControlStateNormal];
        [shareBut addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBut];
        
        
    }
    return self;
}
//pop
- (void)backAction
{
   
    UIViewController *vc = (UIViewController *)self.superview.nextResponder;
    [vc.navigationController popViewControllerAnimated:YES];
}
//收:
- (void)likeAction:(UIButton *)but
{
    if (but.selected) {
        
        _deleteBlock();
        
    }else{
        
        _saveBlock();
        
    }
    but.selected = ! but.selected;
}

- (void)shareAction
{
    _shareBlock();
    
}
@end
