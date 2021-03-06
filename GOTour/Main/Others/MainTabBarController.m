//
//  MainTabBarController.m
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "MainTabBarController.h"
#import "TLTabBarItem.h"

#import "TLNavigationController.h"

#import "SectionViewController.h"
#import "DiscoverViewController.h"
#import "DestinationViewController.h"
#import "MineViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController
{
    NSArray *images;
    NSArray *selectImages;
    
    NSInteger _lastItem;//记录上一个选择的按钮
    

}

-(void)viewWillLayoutSubviews
{
    TLNavigationController *nav1 = [[TLNavigationController alloc] initWithRootViewController:[[SectionViewController alloc]init]];
    
    TLNavigationController *nav2 = [[TLNavigationController alloc] initWithRootViewController:[[DiscoverViewController alloc]init]];
    
    TLNavigationController *nav3 = [[TLNavigationController alloc] initWithRootViewController:[[DestinationViewController alloc]init]];
    
    TLNavigationController *nav4 = [[TLNavigationController alloc] initWithRootViewController:[[MineViewController alloc]init]];
    self.viewControllers = @[nav1,nav2,nav3,nav4];

}
+ (instancetype)shareController
{
    static MainTabBarController *t = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        t = [[MainTabBarController alloc ]init];
        
    });
    
    return t;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _lastItem = 0;
    //加入控制器
    [self addController];
     [self _loadTabBarItem];

}
-(void)addController
{
    



}
-(void)_loadTabBarItem
{
    
    //1.删除系统的

//    self.tabBar.hidden = YES;
//    [self.tabBar removeFromSuperview];
   _tabBarView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
     [self.tabBar addSubview:_tabBarView];
    [self.tabBar bringSubviewToFront:_tabBarView];
    _tabBarView.backgroundColor = [UIColor whiteColor];
//    _tabBarView.userInteractionEnabled = YES;
    
    //2.添加自己的
    images = @[@"tabbar_item_home@2x.png",@"tabbar_item_discover@2x.png",@"tabbar_item_des@2x.png",@"tabbar_item_my@2x.png"];
    selectImages = @[@"tabbar_item_home_sel@2x.png",@"tabbar_item_discover_sel@2x.png",@"tabbar_item_des_sel@2x.png",@"tabbar_item_my_sel@2x.png"];
    
    NSArray *array = @[@"精选",@"发现",@"目的地",@"我的"];
   
    for (int i = 0; i < 4; i++) {
        CGFloat width = kScreenWidth/4;
        CGFloat height = self.tabBar.frame.size.height;
        CGRect rect = CGRectMake(i*width, 0, width, height);
        
        TLTabBarItem *but = [[TLTabBarItem alloc]initWithFrame:rect];
        but.frame = rect;
        //按钮图片
        but.title = array[i];
        if (i == 0) {
            
            but.imageName = selectImages[i];
            but.lable.textColor = [UIColor colorWithRed:209.0/255 green:62.0/255 blue:80.0/255 alpha:1];
    
        }else{
            
            but.imageName = images[i];
        }
       
       //添加事件
        [but addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:but];
         but.tag = 100 + i;
       
    }
    

}
-(void)clickAction:(TLTabBarItem *)button
{
//    NSLog(@"自控件%@",_tabBarView.subviews);
    NSInteger num = button.tag - 100;
    if ( num != _lastItem)
    {
       self.selectedIndex = num;
        
        button.imageName = selectImages[num];
        button.lable.textColor = [UIColor colorWithRed:207.0/255 green:63.0/255 blue:81.0/255 alpha:1];
        //去掉上一个Item的选中状态
        TLTabBarItem *item = _tabBarView.subviews[_lastItem];
        item.imageName = images[_lastItem];
        item.lable.textColor = [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:1];
          _lastItem = num;
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
