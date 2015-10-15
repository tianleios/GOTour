//
//  NavigationBarVIew.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NavigationBarVIew.h"

@implementation NavigationBarVIew
//activity_btnShare.png 白
//view_btn_back.png
//web_btn_back.png

//activity_btnUnLike.png 空心白
//activity_btnLike.png 实心红心
//activity_btnUnLike_red.png 空心红
+ (instancetype)createNavigationBar:(CGRect)frame save:(SaveLikeBlock)save delete:(DeleteLikeBlock)delete
{
    NavigationBarVIew *nv = [[NavigationBarVIew alloc] initWithFrame:frame];
    nv.saveBlock = save;
    nv.deleteBlock = delete;
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
        UIButton *backBut = [[UIButton alloc]initWithFrame:CGRectMake(32, height/2 - 10, 20, 20)];
        [backBut setImage:[UIImage imageNamed:@"web_btn_back.png"] forState:UIControlStateNormal];
        [backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:backBut];
        backBut.contentMode =  UIViewContentModeScaleAspectFill;
        //收藏按钮牛
        UIButton *likeBut = [[UIButton alloc]initWithFrame:CGRectMake(width - 65, height/2 - 22.5 , 45, 45)];
        
        [likeBut setImage:[UIImage imageNamed:@"activity_btnUnLike.png"] forState:UIControlStateNormal];
        
        [likeBut setImage:[UIImage imageNamed:@"activity_btnLike.png"] forState:UIControlStateSelected];

        [likeBut addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBut];
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
    
    
}
@end
