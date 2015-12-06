//
//  SectionViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/01.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "SectionViewController.h"
#import "MainTabBarController.h"
#import "TLDetailViewController.h"
#import "MineViewController.h"
#import "NextDetailViewController.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "WebViewController.h"
#import "SelectModel.h"
#import "MainCollectionModel.h"
#import "SelectionCell.h"
#import <Social/Social.h>
//#import "CollectionCell.h"

#import "SelectModel.h"
#import "MainCollectionModel.h"
#import "SelectFrame.h"

#import "TLScrollVIew.h"
#import "SectionViewController.h"
#import "TopViewController.h"
#import "MBProgressHUD.h"
#import "CollectionModel.h"
#import "CollectionCell1.h"
#import "NSString+Ext.h"

#define kBaseUrl @"http://appsrv.flyxer.com/api/digest/main"
@interface SectionViewController ()

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) UITableView *tableView;


@end

@implementation SectionViewController
{
//    UITableView *_tableView;
    NSMutableArray *_selectFrames;
    NSInteger _firstFlag;

}



- (void)dealloc
{
//
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    
     [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _currentPage = 2;
//    [self addNaviegationBarItem];
        //数据的下载
    [self firesLoadData];
    
//    NSString

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
    
//    //定义导航返回按钮
//    UIImage *image = [UIImage imageNamed:@"btn_back2.png"];
//    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    but2.frame = CGRectMake(10, 10, 30, 30);
//    but2.backgroundColor = [UIColor grayColor];
//    [but2 setImage:image forState:UIControlStateNormal];



}

- (void)createTableView
{
   
        
    UITableView *tv= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 ) style:UITableViewStyleGrouped];
    
    [self.view addSubview:tv];
    _tableView = tv;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    __weak SectionViewController *vc = self;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [vc firesLoadData];
        
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [vc nextLoadData];
    }];
    
  
//    [self addNaviegationBarItem];
}
- (void)firesLoadData
{
    NSLog(@"%ld",(long)_firstFlag);
//    did=14488&page=1&v=2&qid=0
   
    if (_firstFlag < 1) {
        
         _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
    }
    //新方法
    __weak SectionViewController *vc  = self;
    [TLHTTPTool requestHomeDataSuccess:^(id responseObject) {
        
        [vc openData:responseObject flag:YES];
#pragma -mark 创建tableView
        [_progressHUD hide:YES];
        
        if (_tableView == nil) {
            
            [vc createTableView];
            
        }else{
        
            [_tableView reloadData];
        }
        
        
        [vc.tableView.header endRefreshing];
        NSLog(@"刷新成功");
        
        _firstFlag ++;
        
    } fail:^(id error) {
        
        [vc.tableView.header endRefreshing];
            
            
            NSLog(@"数据请求失败");
            [_progressHUD hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"是否重新加载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [vc.view addSubview:alert];
            alert.delegate = self;
            [alert show];

        
    }];
    
}

- (void)nextLoadData
{
//     did=14488&page=1&v=2&qid=0
    NSString *page = [NSString stringWithFormat:@"%ld",(long)_currentPage];
    NSDictionary *para = @{
                           @"did":@"14488",
                           @"page":page,
                           @"v":@"2",
                           @"qid":@"0"
                           };
    __weak SectionViewController *weakSelf = self;
    [TLHTTPTool requestDataWithUrl:kBaseUrl parameters:para success:^(id responseObject) {
        
        [self openData:responseObject flag:NO];
        _currentPage ++;
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        if (_currentPage > 6) {
            [_tableView.footer noticeNoMoreData];
        }
        
    } fail:^(id error) {
        
        NSLog(@"数据请求失败");
        [weakSelf.tableView.header endRefreshing];
    }];

//    UISegmentedControl
}
#pragma - mark 数据解析
-(void)openData:(id)response flag:(BOOL)flag
{
    NSArray *array = response[@"recomms"];
    if (_selectFrames == nil) {
        
     _selectFrames = [NSMutableArray array];
        
    }
    
    NSUInteger i = 0;
    for (NSDictionary *dict in array) {
        
        SelectFrame *selectFrame = [[SelectFrame alloc] init];
        if ([dict[@"type"] isEqualToString:@"Recomm"]) {
            
            selectFrame.selectM = [SelectModel objectWithKeyValues:dict];
            
            if (flag == YES && _firstFlag > 0 ) {
                
                [_selectFrames replaceObjectAtIndex:i withObject:selectFrame];
                
            }else{
                [_selectFrames addObject:selectFrame];
            }
        }
        
        if ([dict[@"type"] isEqualToString:@"Collection"]) {
    
            selectFrame.mainCM = [MainCollectionModel objectWithKeyValues:dict];
            
            if (flag == YES && _firstFlag > 0 ) {
//                 NSLog(@"第er次");
                [_selectFrames replaceObjectAtIndex:i withObject:selectFrame];
            }else{
//                NSLog(@"第一次");
                [_selectFrames addObject:selectFrame];
                
            }
           
//            [_selectFrames addObject:selectFrame];
           
        }
        i++;
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
        CollectionModel *cm = cCell.scrollV.mainCollectionModel.collectionArray[num];
       
        if ([cm.layout isEqual:@0]) {
            WebViewController *web = [[WebViewController alloc]init];
            web.urlString = cm.url;

            [self.navigationController pushViewController:web animated:YES];
        }else{
            TVC.collectionM = cm;
            TVC.urlStr = cCell.scrollV.URLArray[num];
            [self.navigationController pushViewController:TVC animated:NO];
        }
        
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
        [self firesLoadData];
    }


}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
   [[SDImageCache sharedImageCache] clearMemory];
    NSLog(@"section收到内存警告");
}
@end
