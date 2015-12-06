//
//  TopViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/01.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TopViewController.h"
#import "SectionViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "MainTabBarController.h"
#import "CollectionModel.h"
#import "SelectModel.h"
#import "TLDetailViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"

#import "collectionCell2Frame.h"
#import "CollectionCell2.h"
#import "NSString+Ext.h"
#import "MBProgressHUD.h"
#define kTopBaseUrl @"http://appsrv.flyxer.com/api/digest/collection"

#define kScrollMargin 50
/// 109?page=1&v=2
@interface TopViewController ()

@property (nonatomic, strong) NSMutableArray *selectMs;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIAlertView *alertV;


@property (nonatomic, strong) NSMutableArray *frameArray;
@property (nonatomic, assign) CGSize kSize;

@property (nonatomic, strong) UILabel *shortLbl;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation TopViewController
{
    UIImageView *_topImageV;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = NO;
      self.navigationController.navigationBar.hidden = NO;

}


-(void)dealloc
{
    NSLog(@"topView销毁");

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.edgesForExtendedLayout =  UIRectEdgeNone;
//    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _progressHUD.dimBackground = YES;
//    [_progressHUD show:YES];
    
    //设置导航栏右侧按钮
     UIImage *rightImage = [UIImage imageNamed:@"btn_share_red.png"];
    UIButton *rightBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBut setImage:rightImage forState:UIControlStateNormal];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    
    //请求数据
    [self requestData];

    //专场时的图片
    [self setUpTopImage];
    
}
- (void)setUpTopImage
{
    _topImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*2/5)];
    [self.view addSubview:_topImageV];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [_topImageV sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    
   
   
}
-(void)createTableView
{
    CGRect frame = CGRectMake(0, -kScrollMargin, kScreenWidth, kScreenHeight + 80);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];

    [self.view insertSubview:tableView aboveSubview:_topImageV];
    _tableView = tableView;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.backgroundColor = nil;
    _tableView.backgroundView = nil;
    
}
#pragma -mark 请求数据
-(void)requestData
{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *url = [kTopBaseUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_collectionM.ID]];
    NSDictionary *param = @{
                            @"page":@"1",
                            @"v":@"2"
                            };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __weak TopViewController *weakVC = self;
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //数据解析
         [weakVC openData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}
- (void)createAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"是否重新加载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [self.view addSubview:alertView];
    _alertV = alertView;
    [alertView show];
    
}
-(void)openData:(id)response
{
    NSArray *array = response;
    _frameArray = [NSMutableArray arrayWithCapacity:array.count];
    
    _selectMs = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        
        collectionCell2Frame *frame = [[collectionCell2Frame alloc] init];
        
        frame.selectM =  [SelectModel objectWithKeyValues:dict];
        [_frameArray addObject:frame];
        
    }
    [_progressHUD hide:YES];
#pragma -mark 创建tableView
     [self createTableView];
}
#pragma - mark 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        TLDetailViewController *vc = [[TLDetailViewController alloc]init];
        collectionCell2Frame *frame = _frameArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        vc.selectM = frame.selectM;
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.section == 0) {
            return kScreenHeight*2/5;
        }
        
        if (indexPath.section == 1 && indexPath.row == 1 &&_shortLbl != nil) {
            return _shortLbl.frame.size.height+10;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            
            return _titleView.frame.size.height;
        }
        
    }
    
    collectionCell2Frame *frame = _frameArray[indexPath.row];
    return frame.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0.001;
    }
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:@"collect_the_end.png"];
    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    return iv;
}
#pragma - mark datasouse 方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 1;
    }
    if (section == 1) {
        if (_shortLbl != nil) {
            return 2;
        }else{
            return 1;
        }
    }
    return _frameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 0 || indexPath.section == 1) {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];

        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            
            cell.contentView.backgroundColor = nil;
            cell.backgroundView = nil;
            cell.backgroundColor = nil;
          

        }else{
            if (indexPath.row == 0 && indexPath.section ==1) {
                [cell addSubview:_titleView];
            }
            if (indexPath.section == 1 && _shortLbl != nil && indexPath.row ==1) {
                [cell addSubview:_shortLbl];
            }
        
        }
        
        return cell;
    }

    CollectionCell2 *cell = [CollectionCell2 createCellWithTableView:tableView];
    
    cell.frameModel = _frameArray[indexPath.row];
    return cell;
}
-(void)popAction
{
    SectionViewController *SVC = [[SectionViewController alloc]init];

    CATransition  *tran = [CATransition animation];
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:tran forKey:kCATransition];
    [self.navigationController pushViewController:SVC animated:NO];

}
#pragma - mark scrollView带理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算偏移量 设置titleVIew
    [self setUpTitleView:scrollView];
   //设置拉伸效果
    [self setUpStretch:scrollView];
}
- (void)setUpStretch:(UIScrollView *)scrollView
{
//    static CGFloat imageY = _topImageV.frame.size.height;
    CGFloat offSetY = scrollView.contentOffset.y;
//    scrollView.scrollEnabled = YES;
    if (scrollView.contentOffset.y < 0) {
        
        if (offSetY < -kScrollMargin*2) {
            scrollView.contentOffset = CGPointMake(0, -kScrollMargin*2);
        }else{
         _topImageV.transform = CGAffineTransformMakeTranslation(0, -offSetY/2);
        }

        
    }else{
     _topImageV.transform = CGAffineTransformMakeTranslation(0, -offSetY/2);
    }


}
- (void)setUpTitleView:(UIScrollView *)scrollView
{
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 -75, 0, 150, 40)];
    lbl.textColor = [UIColor orangeColor];
    lbl.font  = [UIFont boldSystemFontOfSize:20];
    lbl.text = _collectionM.title;
    lbl.textAlignment = NSTextAlignmentCenter;
    if (scrollView.contentOffset.y > kScreenHeight/3 - 20) {
        
        self.navigationItem.titleView = lbl;
    }
    if (scrollView.contentOffset.y < kScreenHeight/3 ) {
        
        self.navigationItem.titleView = nil;
    }

}
#pragma - mark 重写set方法
-(void)setCollectionM:(CollectionModel *)collectionM
{
    _collectionM = collectionM;
    
#pragma - mark头部简介
    if (collectionM.short_desc != nil) {
        UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(kScreenWidth - 4*kMargin, MAXFLOAT);
     _kSize = [NSString calculateStringSize:size string:_collectionM.short_desc font:font];
        _shortLbl = [[UILabel alloc]initWithFrame:CGRectMake(3*kMargin, 0, _kSize.width , _kSize.height)];
        _shortLbl.font = font;
        
        _shortLbl.text = collectionM.short_desc;
//        _shortLbl.textAlignment = NSTextAlignmentRight
        _shortLbl.numberOfLines = 0;
        
    
        
        
    }
    _titleView = [[UIView alloc]init];
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    lbl1.text = _collectionM.title;
//    lbl1.backgroundColor = [UIColor redColor];
    [_titleView addSubview:lbl1];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.font = [UIFont systemFontOfSize:25];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 0)];
    lbl2.hidden = YES;
    if (_collectionM.sub_title.length != 0) {
        lbl2.hidden = NO;
        lbl2.frame = CGRectMake(0, 60, kScreenWidth, 30);
        lbl2.text = _collectionM.sub_title;
        [_titleView addSubview:lbl2];
//        lbl2.backgroundColor = [UIColor orangeColor];

        lbl2.textAlignment = NSTextAlignmentCenter;
        lbl2.font = [UIFont systemFontOfSize:14];
        
    }
    
    CGFloat y = CGRectGetMaxY(lbl2.frame) + kMargin;
    _titleView.frame = CGRectMake(0, 0, kScreenWidth, y);
    _titleView.backgroundColor = [UIColor orangeColor];
    _titleView.backgroundColor = [UIColor whiteColor];
    

}
#pragma -mark alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSelector:@selector(requestData)];
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    NSLog(@"top收到内存警告");
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
