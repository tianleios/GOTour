//
//  TLLoginVC.m
//  GOTour
//
//  Created by 田磊 on 16/3/24.
//  Copyright © 2016年 tianLei. All rights reserved.
//

#import "TLLoginVC.h"
#import "MBProgressHUD.h"
#define kMargin 10
@implementation TLLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat height = 50.0;
    //1.账号
    UITextField *countTF = [[UITextField alloc] initWithFrame:CGRectMake( kMargin , 10*kMargin, kScreenWidth - 2*kMargin, height)];
    countTF.backgroundColor = [UIColor cyanColor];
//    countTF.placeholder = @"在此输入账号";
    countTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"在此输入账号" attributes:@{
                                                                                                      NSForegroundColorAttributeName :[UIColor blackColor],
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:16]
    }];
    [self.view addSubview:countTF];
    
    //3.密码
    UITextField *secretTF = [[UITextField alloc] initWithFrame:CGRectMake(kMargin, countTF.yy + 2*kMargin, kScreenWidth - 2*kMargin, height)];
//    secretTF.placeholder = @"这里是密码";
    secretTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"这里是密码" attributes:@{
                                                                                                      NSForegroundColorAttributeName :[UIColor blackColor],
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:16]
                                                                                                      }];
    secretTF.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:secretTF];
    
    //3.登录按钮
    UIButton *loginBut = [[UIButton alloc] initWithFrame:CGRectMake(2*kMargin, secretTF.yy + 3*kMargin, kScreenWidth - 4*kMargin, height)];
    loginBut.backgroundColor = [UIColor orangeColor];
    [loginBut setTitle:@"登录" forState:UIControlStateNormal];
    [loginBut addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBut];
    


}

- (void)loginAction
{
   MBProgressHUD *hud =  [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.loginBlock) {
            
            self.loginBlock();
            
        }
        
    });

    

}
@end
