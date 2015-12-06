//
//  TLTabBarController.m
//  GOTour
//
//  Created by 磊 田 on 15/10/20.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "TLTabBarController.h"
#import "TLNavigationController.h"

#import "SectionViewController.h"
#import "DiscoverViewController.h"
#import "DestinationViewController.h"
#import "MineViewController.h"
#import "UserViewController.h"

@interface TLTabBarController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectImage;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectImages;



@end

@implementation TLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self setUpTabBarItem];
}

- (void)setUpTabBarItem
{
    _images = @[@"tabbar_item_home.png",@"tabbar_item_discover.png",@"tabbar_item_des.png",@"tabbar_item_my.png"];
    _selectImages = @[@"tabbar_item_home_sel.png",@"tabbar_item_discover_sel.png",@"tabbar_item_des_sel.png",@"tabbar_item_my_sel.png"];
    
    NSArray *array = @[@"精选",@"发现",@"目的地",@"我的"];
    
    NSArray *vcArray = @[[[SectionViewController alloc]init],[[DiscoverViewController alloc]init],[[DestinationViewController alloc]init],[[UserViewController alloc]init]];
    
    for (int i = 0; i < 4; i++) {
        
        [self imageName:_images[i] selectImage:_selectImages[i] title:array[i] viewController:vcArray[i]];
        
    }
    
    
}

- (void)imageName:(NSString *)string selectImage:(NSString *)name title:(NSString *)title viewController:(UIViewController *)vc
{
    _image = [UIImage imageNamed:string];
    _selectImage = [UIImage imageNamed:name];
    
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] > 7 && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//        
//         [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 10, 0, 10)];
//        NSLog(@"你在家");
//    }
    
   
    
    vc.tabBarItem.image = [_image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [_selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor redColor]} forState:UIControlStateSelected];
    
    vc.tabBarItem.title = title;
    
    TLNavigationController *nvc = [[TLNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nvc];
    
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
