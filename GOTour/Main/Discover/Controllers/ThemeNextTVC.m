//
//  ThemeNextTVC.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ThemeNextTVC.h"
#import "MBProgressHUD.h"

#import "ThemeNextCell.h"
#import "TLDetailViewController.h"

#define kThemeUrl @"http://appsrv.flyxer.com/api/digest/recomm/tag/"
@interface ThemeNextTVC ()

@property (nonatomic, strong) NSMutableArray *selects;
@property (nonatomic, weak)   UITableView *detailTableView;
@end

@implementation ThemeNextTVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = NO;

    self.title = _name;
    self.view.backgroundColor = [UIColor whiteColor];
    //请求数据
    [self requsetData];
//    NSLog(@"%f",self.tableView.frame.origin.y);
    
//    self.tableView.style = UITableViewStyleGrouped;
    
}

- (void)requsetData
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlStr = [kThemeUrl stringByAppendingString:[_ID stringValue]];
    
    NSDictionary *dict = @{
                           @"page":@"1",
                           @"did":@"18652",
                           @"v":@"2"
                           };
    
    [TLHTTPTool requestDataWithUrl:urlStr parameters:dict success:^(id responseObject) {
        
        NSArray *array = responseObject;
        _selects = [NSMutableArray array];
        
        for (NSDictionary *dictionary in array) {
            
            SelectModel *model = [SelectModel objectWithKeyValues:dictionary];
            if (model.ID != nil) {
                [_selects addObject:model];
            }
         
            NSLog(@"%@",model.ID);
        }
        [self createTableView];

        [progressHUD hide:YES];
    } fail:^(id error) {
        
    }];
    


}

- (void)createTableView
{
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,y, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
    
    _detailTableView = tableV;
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.backgroundColor = [UIColor clearColor];
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLDetailViewController *vc = [[TLDetailViewController alloc] init];
    vc.selectM = _selects[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _selects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThemeNextCell *cell = [ThemeNextCell createCellWithTableView:tableView];
    cell.selectM = _selects[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth/1.6 + 4;

}

@end
