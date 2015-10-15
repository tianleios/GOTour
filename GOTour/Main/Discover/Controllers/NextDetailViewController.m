//
//  NextDetailViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NextDetailViewController.h"

#import "TLDetailViewController.h"

#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "NSString+Ext.h"

#import "NextStepModel.h"
#import "DetailModel.h"
#import "SelectModel.h"

#import "HeadCell.h"
#import "ImageCell.h"
#import "TextCell.h"
#import "NextDetailCell.h"
#import "ReferrerCell.h"


#import "DetailCellFrame.h"

#define kNextBaseUrl @"http://appsrv.flyxer.com/api/digest/article/"

@interface NextDetailViewController ()

@property (nonatomic, strong) NextStepModel *nextModel;

@property (nonatomic, weak) UITableView *detailTableView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, assign) CGFloat titleHeight;


//尺寸数组
@property (nonatomic, strong) NSMutableArray *frames;

@end


@implementation NextDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [but setImage:[UIImage imageNamed:@"btn_share_red.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = rightItem;
    //请求数据
    [self requestData];
    
}
- (void)requestData
{
  _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [kNextBaseUrl stringByAppendingString:[_ID stringValue]];
    
    [TLHTTPTool requestDataWithUrl:url parameters:nil success:^(id responseObject) {
        
    //数据请求并保存
    _nextModel = [NextStepModel objectWithKeyValues:responseObject];
     //根据数据计算 frame
        [self calculateFrame];
       
        [_progressHUD hide:YES];
#pragma -mark 创建tableView
        //计算title的高度
        [self setTitleH];
        [self createTableView];
    } fail:^(id error) {
        NSLog(@"请求数据失败");
    }];

}
- (void)setTitleH
{
    CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 6*kMargin, MAXFLOAT) string:_nextModel.title font:[UIFont systemFontOfSize:25]];
    
    _titleHeight = size.height;

}
- (void)calculateFrame
{
    _frames = [NSMutableArray arrayWithCapacity:_nextModel.body.count];
    for (DetailModel *model in _nextModel.body) {
        
        DetailCellFrame *frame = [[DetailCellFrame alloc]init];
        frame.detailM = model;
        [_frames addObject:frame];
    }


}
#pragma - mark 创建tableView
- (void)createTableView
{
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,y, kScreenWidth, kScreenHeight - y) style:UITableViewStyleGrouped];
    
    _detailTableView = tableV;
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
//    _detailTableView.backgroundColor = [UIColor clearColor];
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTableView];
}

#pragma  - mark 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _nextModel.body.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth *3.5/8)];
        NSURL *url  = [NSURL URLWithString:_nextModel.bg_pic];
        [iv sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
        [cell addSubview:iv];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    DetailCellFrame *frame =  _frames[indexPath.row];
    NSString *type  = frame.detailM.type;
    //标题
    if ([type isEqualToString:@"head"]) {
        
        HeadCell *cell = [HeadCell createCellWith:tableView];
        cell.frameM = frame;
        return cell;
    }
    //正文
    if ([type isEqualToString:@"text"]) {
        
        TextCell *cell = [TextCell createCellWith:tableView];
        cell.frameM = frame;
        return cell;
    }
    //可进一步点击
    if ([type isEqualToString:@"recomm"]) {
        NextDetailCell *cell = [NextDetailCell createCellWithTableView:tableView block:^{
        }];
        cell.frameM = frame;
        
        
        return cell;
    }
    // 图片
    ImageCell *cell = [ImageCell createCellWith:tableView];
    cell.frameM = frame;
    return cell;
    

    
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[NextDetailCell class]]) {
        NextDetailCell *nextCell = (NextDetailCell *)cell;
       
        NSString *str = [NSString stringWithFormat:@"http://appsrv.flyxer.com/api/digest/recomm/%@?v=2",nextCell.detailModel.content.ID];
        [TLHTTPTool requestDataWithUrl:str parameters:nil success:^(id responseObject) {
            
            TLDetailViewController *vc = [[TLDetailViewController alloc] init];
            SelectModel *model  = [SelectModel objectWithKeyValues:responseObject];
            vc.selectM = model;
            [self.navigationController pushViewController:vc animated:YES];
            
            NSLog(@"成功");
        } fail:^(id error) {
            NSLog(@"失败");
        }];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return kScreenWidth*3.5/8;
    }
    DetailCellFrame *frame = _frames[indexPath.row ];
    return  frame.rowHeight;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 1) {
//        return ;
//
//    }
    return 0.01 ;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return _titleHeight + 2*kMargin;
    }
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(2*kMargin, 2*kMargin, kScreenWidth - 6*kMargin, _titleHeight)];
        lbl.text = _nextModel.title;
        lbl.numberOfLines = 0;
        lbl.font = [UIFont systemFontOfSize:25];
        
        UIView *vl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,_titleHeight + kMargin *2)];
        vl.backgroundColor = [UIColor whiteColor];
        [vl addSubview:lbl];
        return vl;
    }
    return nil;

}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    
//}

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
