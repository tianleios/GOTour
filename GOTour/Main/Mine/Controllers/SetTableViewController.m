//
//  SetTableViewController.m
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "SetTableViewController.h"
#import "MBProgressHUD.h"

@interface SetTableViewController ()

@end
@interface SetTableViewController()


@end
@implementation SetTableViewController
-(void)dealloc
{
    NSLog(@"设置界面被销毁");


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//   _cache = [SDImageCache sharedImageCache];
//   _cacheSize = [_cache getSize];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"几次");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"清除缓存";

    NSInteger size = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"%ld",(long)size);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",size/(1024*1024.0)];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    hud.labelText = @"正在清除缓存";
    __weak SetTableViewController *weakSelf = self;
   [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
       hud.mode = MBProgressHUDModeText;
       hud.labelText = @"清除成功";
       
       [weakSelf.tableView reloadData];
       [hud hide:YES afterDelay:1];
   }];

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];


}
@end
