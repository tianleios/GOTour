//
//  ListViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/9.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ListViewController.h"

#import "SelectModel.h"
#import "MJExtension.h"
#import "TLDetailViewController.h"

#import "ListCell.h"

#import "MBProgressHUD.h"

#define kBaseUrl @"http://appsrv.flyxer.com/api/digest/recomm/dest/"
@interface ListViewController ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIAlertView *alertV;

@property (nonatomic, strong) NSMutableArray *selects;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@property (nonatomic, strong) NSMutableDictionary *refreshDict;

@property (nonatomic, assign) NSInteger count;//记录重新加载次数

@end

@implementation ListViewController
-(void)dealloc
{
    NSLog(@"dealloc listView被销毁");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;

    self.title = @"热门产品";
    self.view.backgroundColor = [UIColor whiteColor];
    _count = 2;
       // 请求数据
    [self firstRequestData];
    
}
- (void)createTopImage
{
    //
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    NSURL *url =[NSURL URLWithString:_firstM.bg_pic];
    [imageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    
}

- (void)addBut
{
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
    [but setImage:[UIImage imageNamed:@"share_left_s.png"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    
}
-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];


}

- (void)firstRequestData
{
    _refreshDict = [[NSMutableDictionary alloc]initWithCapacity:2];
    _refreshDict[@"page"] = @"1";
    _refreshDict[@"v"] = @"2";
    NSString *str = [kBaseUrl stringByAppendingString:[_firstM.ID stringValue]];
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TLHTTPTool requestDataWithUrl:str parameters:_refreshDict success:^(id responseObject) {
       
        NSArray *array = responseObject;
        
        _selects = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            SelectModel *model = [SelectModel objectWithKeyValues:dict];
            [_selects addObject:model];
        }
        [_progressHUD hide:YES];
#pragma -mark请求成功 创建tableView
        [self createTableView];
       
    } fail:^(id error) {
       [_progressHUD hide:YES];
        [self createAlertView];
    }];

    

}
#pragma - mark 下拉刷新调用的请求数据方法
- (void)NextRequestData
{
   
   
    if (_count < 4) {
    
        _refreshDict = [[NSMutableDictionary alloc]initWithCapacity:2];
        _refreshDict[@"page"] = [NSString stringWithFormat:@"%ld",(long)_count];
        _refreshDict[@"v"] = @"2";
        
        NSString *str = [kBaseUrl stringByAppendingString:[_firstM.ID stringValue]];
        [TLHTTPTool requestDataWithUrl:str parameters:_refreshDict success:^(id responseObject) {
            
            NSArray *array = responseObject;
            for (NSDictionary *dict in array) {
                SelectModel *model = [SelectModel objectWithKeyValues:dict];
                [_selects addObject:model];
            }
              //刷新tableView
              [_tableView reloadData];
            _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self NextRequestData];
            }];
            //请求成功计数加以
            _count ++;
        } fail:^(id error) {
            NSLog(@"数据请求失败");
            [_tableView.footer endRefreshing];
            
        }];
        
    }else{
        
        [_tableView.footer noticeNoMoreData];
    }
    
    
}

- (void)createAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"是否重新加载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [self.view addSubview:alertView];
    _alertV = alertView;
    [alertView show];

}

- (void)createTableView
{
    __weak ListViewController *vc = self;

    
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - y) style:UITableViewStylePlain];
    
    [self.view addSubview:tableV];
    _tableView = tableV;
    _tableView.rowHeight = kScreenWidth/3.9 +kMargin;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
               [vc NextRequestData];
     }];
     footer.automaticallyRefresh = NO;
    _tableView.footer = footer;

   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLDetailViewController *tlVC = [[TLDetailViewController alloc] init];
   
    SelectModel *model = _selects[indexPath.row];
    tlVC.selectM = model;
    [self.navigationController pushViewController:tlVC animated:YES];
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return _selects.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return  [ListCell createCellWithTableView:tableView model:_selects[indexPath.row]];
    
}


#pragma -mark alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSelector:@selector(firstRequestData)];
    }

    
    
    
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
