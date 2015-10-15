//
//  TLNavigationController.m
//  旅行
//
//  Created by 磊 田 on 15/9/30.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLNavigationController.h"
#import "MainTabBarController.h"
@interface TLNavigationController ()

@end

@implementation TLNavigationController
+(void)initialize
{
   UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSDictionary *dict = @{
                           
                           NSForegroundColorAttributeName :[UIColor redColor]
                           };
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background@2x.png"]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   

    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;

        UIImage *image = [UIImage imageNamed:@"btn_back2.png"];
        UIButton *but2 = [[UIButton alloc]initWithFrame: CGRectMake(10, 10, 40, 40)];
        [but2 setImage:image forState:UIControlStateNormal];
        [but2 addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:but2];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    
    [super pushViewController:viewController animated:YES];
}
-(void)popAction
{
    [self popViewControllerAnimated:YES];
    

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
