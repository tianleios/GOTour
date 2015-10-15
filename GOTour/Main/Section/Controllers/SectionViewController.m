//
//  SectionViewController.m
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "SectionViewController.h"
#import "MainTabBarController.h"
#import "TLDetailViewController.h"
#import "MineViewController.h"

#import "AFNetworking.h"
#import "SDImageCache.h"

#import "SelectModel.h"
#import "MainCollectionModel.h"
#import "SelectionCell.h"
//#import "CollectionCell.h"

#import "SelectModel.h"
#import "MainCollectionModel.h"
#import "SelectFrame.h"

#import "TLScrollVIew.h"
#import "SectionViewController.h"
#import "TopViewController.h"
#import "MBProgressHUD.h"

#import "CollectionCell1.h"
#import "NSString+Ext.h"

#define kBaseUrl @"http://appsrv.flyxer.com/api/digest/main?did=14488&page=1&v=2&qid=0"
@interface SectionViewController ()

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end

@implementation SectionViewController
{
    UITableView *_tableView;
    NSMutableArray *_selectFrames;

}

- (void)dealloc
{
    NSLog(@"第一控制器 被销毁");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
  
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = [UIColor whiteColor];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addNaviegationBarItem];
        //数据的下载
    [self loadData];

}
- (void)addNaviegationBarItem
{
    //返回顶部按钮
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(300, 300, 25, 50)];
    [but addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    UIImage *img = [UIImage imageNamed:@"activity_moreD2.png"];
    [but setImage:img forState:UIControlStateNormal];
    [self.view insertSubview:but aboveSubview:_tableView];
    but.backgroundColor = [UIColor clearColor];
    //定义导航返回按钮
    UIImage *image = [UIImage imageNamed:@"btn_back2.png"];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 10, 30, 30);
    but2.backgroundColor = [UIColor grayColor];
    [but2 setImage:image forState:UIControlStateNormal];



}
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)loadData
{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [TLHTTPTool requestDataWithUrl:kBaseUrl parameters:nil success:^(id responseObject) {
         [self openData:responseObject];
#pragma -mark 创建tableView
        [_progressHUD hide:YES];
        [self createTableView];
        
    } fail:^(id error) {
        
        NSLog(@"数据请求失败");
         [_progressHUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"是否重新加载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [self.view addSubview:alert];
        alert.delegate = self;
        [alert show];
        
    }];
    

}
#pragma - mark 数据解析
-(void)openData:(id)response
{
    NSArray *array = response[@"recomms"];
    _selectFrames = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        SelectFrame *selectFrame = [[SelectFrame alloc] init];
        if ([dict[@"type"] isEqualToString:@"Recomm"]) {
            
            selectFrame.selectM = [SelectModel objectWithKeyValues:dict];
            [_selectFrames addObject:selectFrame];
          
        }
        if ([dict[@"type"] isEqualToString:@"Collection"]) {
    
            selectFrame.mainCM = [MainCollectionModel objectWithKeyValues:dict];
            [_selectFrames addObject:selectFrame];

        }
    }
}
-(void)action
{
 
    [_tableView setContentOffset:CGPointMake(0, 0)];
}

#pragma - mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TopViewController *TVC = [[TopViewController alloc]init];
    //根据不通的cell类型 进行不同的跳转
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Class cl = NSClassFromString(@"CollectionCell1");
    
    if ([cell isKindOfClass:cl]) {
        CollectionCell1 *cCell =(CollectionCell1 *)cell;
        
        NSInteger num = cCell.scrollV.contentOffset.x/kScreenWidth;
        TVC.collectionM = cCell.scrollV.mainCollectionModel.collectionArray[num];
        
        TVC.urlStr = cCell.scrollV.URLArray[num];
        [self.navigationController pushViewController:TVC animated:NO];
    }else{
        
        TLDetailViewController *DVC = [[TLDetailViewController alloc]init];
        [self.navigationController pushViewController:DVC animated:YES];
        SelectionCell *sCell = (SelectionCell *)cell;
        DVC.selectM = sCell.selectFrame.selectM;
    }
    
}
#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _selectFrames.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SelectFrame *Sframe = _selectFrames[indexPath.section];
    SelectModel *sm  =  Sframe.selectM;
    MainCollectionModel *mcm = Sframe.mainCM;
    
    if (sm != nil) {
        SelectionCell *cell = [SelectionCell createCelllWithTableView:tableView];
      __weak SectionViewController *sc = self;
        cell.topButBlock = ^{
            MineViewController *vc = [[MineViewController alloc] init];
            vc.referrer = Sframe.selectM.referrer;
            vc.isUser = YES;
            [sc.navigationController pushViewController:vc animated:YES];
            
        };
        cell.selectFrame = Sframe;
        return cell;
    }
    
    if (mcm != nil) {
        CollectionCell1 *cell = [CollectionCell1 createCelllWithTableView:tableView];
        cell.selectFrame = Sframe;
        return cell;
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectFrame *Myframe = _selectFrames[indexPath.section];
    
    return Myframe.rowHeight;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 5;
    
}
#pragma -markalertView 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self loadData];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];


}
@end
