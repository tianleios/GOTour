//
//  WebViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"
@interface WebViewController ()

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
//    CGFloat y =CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _webView = webView;
    _webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    NSLog(@"开始加载");
    _progressHUD = [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    _progressHUD.labelText = @"正在加载中";


}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    _progressHUD.mode = MBProgressHUDModeText;
//    _progressHUD.labelText = @"加载成功";
    [_progressHUD hide:YES ];
    NSLog(@"加载完毕");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = @"加载失败";
    [_progressHUD hide:YES afterDelay:1.5];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
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
