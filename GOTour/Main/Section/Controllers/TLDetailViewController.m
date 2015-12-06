//
//  TLDetailViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLDetailViewController.h"
#import "MapViewVC.h"
#import "LikeUserLIstTVC.h"
#import "WebViewController.h"
#import <Social/Social.h>

#import "NavigationBarVIew.h"
#import "SelectModel.h"
#import "DetailModel.h"

#import "DetailCellFrame.h"
#import "DetailBootomCellFrame.h"

#import "CommentModel.h"

#import "HeadCell.h"
#import "TextCell.h"
#import "ImageCell.h"
#import "ReferrerCell.h"
#import "LastCell.h"
#import "ExpenseCell.h"
#import "TimeCell.h"
#import "LocationCell.h"
#import "LikeCell.h"
#import "OrderCell.h"

#import "AFNetworking.h"
#import "MJExtension.h"

#import "CellAssessoryBut.h"
#import "LoadMoreBut.h"
#import "TLTitleView.h"
#import "ShareView.h"
#define kScrollMargin 20
#define kFootViewHeight 30
#define kCommentUrl @"http://appsrv.flyxer.com/api/comment/recomm/"

#define kExpense @"expenseFlag"
#define kTime @"timeFlag"
#define kOrder @"orderFlag"

@interface TLDetailViewController ()

@property (nonatomic, strong) UIImageView *topIV;
@property (nonatomic, weak) UITableView *detailTableView;

//模型数组
@property (nonatomic, strong) NSMutableArray *frames;

//第一次加载数据的个数
@property (nonatomic, assign) NSInteger firstLoadCount;
//加载的cell数
@property (nonatomic, assign) NSInteger loadCount;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) BOOL moreFlag; //加载更多相关标志
@property (nonatomic, assign) BOOL isHiddenLoadMore; //加载更多相关标志

@property (nonatomic, strong) ShareView *shareView;

//关于详情页面下方的字典
@property (nonatomic, strong) NSMutableDictionary *detailBootomDict;

//评论
@property (nonatomic, strong) CommentModel *comment;
//最下方 花费 评论 模型
@property (nonatomic, strong) DetailBootomCellFrame *detailBootomCellFrame;
//标志字典 判断cell展开还是 收缩
@property (nonatomic, strong) NSMutableDictionary *flagDict;

/**
 * 图片浏览器需要的str
 */
//@property (nonatomic, strong) NSMutableArray *imageStrs;

@property (nonatomic, strong) NSMutableArray *imageUrls;


@end

@implementation TLDetailViewController
{

    UIButton *shareBut;
}


-(void)dealloc
{
    
    NSLog(@"TLDetailViewController销毁了");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addNavigationBarItem];
    self.navigationController.navigationBar.hidden = YES;
     self.view.backgroundColor = [UIColor whiteColor];

    _moreFlag = YES;
    _flag = YES;
    //创建标志字典
    [self createFlagDict];

    //顶部大图片
    [self createTopImageAndShareView];
   //数据保存
//      [TLHTTPTool saveDataWithModel:_selectM imageV:_topIV];
    
    //顶部
    [self navigationBarView];
    
#pragma -mark  获取评论的数据
//    [self getCommentData];
    

    //tableView
    [self createTableView];
    
    
    
}

#pragma - mark 三方分享
- (void)sinaWeibo
{
    
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"562b060c67e58e45640004fd"
                                      shareText:@"你要分享的文字"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatFavorite,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    //判读 是否能进行分享
    
//    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        
//        NSLog(@"不能进行分享");
//    }
//    
//    
//    
//    SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//    
//    [compose setInitialText:_selectM.short_desc];
    
//   NSDate *imageData = UIImageJPEGRepresentation(self.imageCache, 0.1);
//    UIImage *image = [UIImage imageWithData:imageData];
//    [compose addImage:image];
    
//    [self presentViewController:compose animated:YES completion:^{
//        
//    }];




}
- (void)createFlagDict
{
    _flagDict = [NSMutableDictionary dictionaryWithCapacity:3];
    _flagDict[@"expenseFlag"] = @2;
    _flagDict[@"timeFlag"] = @2;
    //订购方式
    _flagDict[@"orderFlag"] = @2;

}
//调用修改flag
-(void)changeFlagAndIncrementByKey:(NSString *)key
{
    NSInteger flag = [_flagDict[key] integerValue];
    NSInteger flag1 = flag + 1;
    _flagDict[key] = @(flag1);

}
//通过key获取是否在下拉状态 0 yes  1 no
-(BOOL)getFlagByKey:(NSString *)key
{
    NSInteger flag = [_flagDict[key] integerValue];
    flag = flag%2;
    if (flag == 0) {
        return YES;
    }
    return NO;
}
// 下拉相关
-(void)accessoryActionWithKey:(NSString *)key row:(NSInteger)row section:(NSInteger)section
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
    if ([self getFlagByKey:key]) {
        [self changeFlagAndIncrementByKey:key];
        
        [_detailTableView insertRowsAtIndexPaths:@[path] withRowAnimation:YES];
    }else{
        [self changeFlagAndIncrementByKey:key];
        [_detailTableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }



}
//根据状态 判断换回row的个数

- (void)getCommentData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    NSString *ID = [_selectM.ID stringValue];

    NSString *urlStr = [kCommentUrl stringByAppendingString:ID];
    
    NSDictionary *dict = @{
                           @"page":@"1",
                           @"size" :@"5"
                           };
    __weak TLDetailViewController *weakVC = self;
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictonary = responseObject;
        weakVC.comment = [CommentModel objectWithKeyValues:dictonary];
        
//        //加载评论需要的条件
//        [self loadLastCellData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
//导航栏右侧按钮
-(void)addNavigationBarItem
{

    UIImage *shareImage = [UIImage imageNamed:@"btn_share_red.png"];
    shareBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [shareBut setImage:shareImage forState:UIControlStateNormal];
   
    [shareBut addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:shareBut];
    
    UIImage *likeImage = [UIImage imageNamed:@"activity_btnUnLike_red.png"];
    UIButton *likeBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    likeBut.contentMode = UIViewContentModeScaleToFill;
    [likeBut setImage:likeImage forState:UIControlStateNormal];
    [likeBut setImage:[UIImage imageNamed:@"activity_btnLike.png"] forState:UIControlStateSelected];
    [likeBut addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:likeBut];

    self.navigationItem.rightBarButtonItems =@[item2,item1];
}
- (void)likeAction:(UIButton *)but
{
    if (but.selected == NO) {
        
        [TLHTTPTool saveDataWithModel:_selectM imageV:self.topIV];
        
    }else{
        
        [TLHTTPTool deleteDataByID:self.selectM.ID];
    }
    
    but.selected = !but.selected;


}
- (void)shareAction
{
    [self sinaWeibo];
//    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [control addTarget:self action:@selector(hiddenAction:) forControlEvents:UIControlEventTouchUpInside];
//    control.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//    [self.view.window addSubview:control];
//    
//    _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenWidth/2)];
//    
//    [control addSubview:_shareView];
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        _shareView.transform = CGAffineTransformMakeTranslation(0, -kScreenWidth/2);
//    }];
    
}
- (void)hiddenAction:(UIControl *)control
{
    __weak TLDetailViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.shareView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        control.hidden  = YES;
    }];

}
#pragma - mark 创建tableView
- (void)createTableView
{
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,-kScrollMargin, kScreenWidth, kScreenHeight + kScrollMargin) style:UITableViewStyleGrouped];
    
    [self.view insertSubview:tableV aboveSubview:_topIV];
    _detailTableView = tableV;

    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.backgroundColor = [UIColor clearColor];
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)createTopImageAndShareView
{
    _topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kScrollMargin, kScreenWidth, 3*kScreenHeight/8 + 2*kScrollMargin)];
    [self.view addSubview:_topIV];
    if (_imageCache == nil) {
        NSString *urlStr = _selectM.bg_pic[0];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_topIV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place_hoder"]];
    }else{
        _topIV.image = _imageCache;
    
    }
   
    
    
}
-(void)navigationBarView
{
    __weak TLDetailViewController *weakSelf = self;
    NavigationBarVIew *barView = [NavigationBarVIew createNavigationBar:self.navigationController.navigationBar.frame save:^{
        
        [TLHTTPTool saveDataWithModel:weakSelf.selectM imageV:weakSelf.topIV];
        
    } delete:^{
        
        if (_dataID == nil) {
            
            [TLHTTPTool deleteDataByID:weakSelf.selectM.ID];
        }else{
            NSLog(@"%@",weakSelf.dataID);
            [TLHTTPTool deleteDataByID:weakSelf.dataID];
        }
        
        
    } share:^{
        [weakSelf shareAction];
    }];
    
    if (_isLike == YES) {
        
      barView.likeBut.selected = YES;
        
    }
  
    [self.view addSubview:barView];
   
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 4) {
        
       
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kScreenHeight * 3/8;
    }
    if (indexPath.section == 1) {
        return 40;
    }
    if (indexPath.section == 2) {
        return 65;
    }
    if (indexPath.section == 4) {
        
        if([self getFlagByKey:kExpense] || indexPath.row == 0)
        {
          return 40;
            
        }else{
                return _detailBootomCellFrame.expenseCellHeight;
            }
      
    }
    if (indexPath.section == 5) {
        
        if([self getFlagByKey:kTime] || indexPath.row == 0)
        {
            return 40;
            
        }else{
            return _detailBootomCellFrame.timeCellHeight;
        }
        
    }

    if (indexPath.section == 6) {
        
        if([self getFlagByKey:kOrder] || indexPath.row == 0)
        {
            return 40;
            
        }else{
            return _detailBootomCellFrame.orderCellHeight;
        }
        
    }
    

    if (indexPath.section > 4) {
        return 40;
    }
    if (indexPath.section == 3) {
        DetailCellFrame *frame =  _frames[indexPath.row];
        return frame.rowHeight;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        return 20;
    }
    if (section > 3) {
        return 0.0001;
    }
    return 0.001;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section == 3) {
        return kFootViewHeight;
    }
    if (section == 1 || section == 2) {
        return 20;
    }

    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        
     if (_isHiddenLoadMore == NO) {
    
        CGRect frame = CGRectMake(200, 10, 100,kFootViewHeight);
         __weak TLDetailViewController *weakVC =self;
        LoadMoreBut *loadMoreBut = [LoadMoreBut createLoadMoreButtonWithFrame:frame flag:_moreFlag actionBlock:^{
            
            [weakVC loadMoreAction];
            
        }];
        

        return loadMoreBut;
        
        }
        
    }
    return nil;

}
#pragma - mark 点击加载更多数据
- (void)loadMoreAction
{
   
      NSInteger more = _frames.count - _firstLoadCount;
   
        
    if (_flag == YES) {
        _loadCount = _frames.count;
      
        NSMutableArray *moreArray = [NSMutableArray arrayWithCapacity:more];
        
    
        for (int i = 0; i < more; i++) {

            NSIndexPath *ip = [NSIndexPath indexPathForRow:_firstLoadCount + i inSection:3];
            [moreArray addObject:ip];
        }
        [_detailTableView insertRowsAtIndexPaths:moreArray withRowAnimation:YES];
        

    }else{
        _loadCount = _firstLoadCount;
        [_detailTableView reloadData];
    
    }
    
    _moreFlag =!_moreFlag;
    _flag = !_flag;
}
#pragma mark - dataSourse 方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section < 3) {
        return 1;
    }
    
    //花费详情
    if (section == 4 ) {
        
        if ([self getFlagByKey:kExpense]) {
            return 1;
        }else{
            return 2;
        }
    }
    if (section == 5 ) {
        
        if ([self getFlagByKey:kTime]) {
            return 1;
        }else{
            return 2;
        }
    }
    if (section == 6 ) {
        
        if ([self getFlagByKey:kOrder]) {
            return 1;
        }else{
            return 2;
        }
    }

    if (section == 7) {
        return 1;
    }
    
   //等于三的时候
    return _loadCount;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头部
    if (indexPath.section < 3 ) {
        return [self createTopCell:tableView indexPath:indexPath];
    }
    //底部
   
    if (indexPath.section == 4) {
        
        if (indexPath.row == 0) {
            
         return [self createLastCell:tableView indexPath:indexPath];
            
        }else{
            
         return [self createLastSecondCell:tableView indexPath:indexPath];
        
        }
       
        
    }
    if (indexPath.section == 5) {
        
        if (indexPath.row == 0) {
            
            return [self createLastCell:tableView indexPath:indexPath];

        }else{
            
            return [self createLastSecondCell:tableView indexPath:indexPath];
        
        }
        
    }
    //订购方式和电话
    if (indexPath.section == 6) {
        
        if (indexPath.row == 0) {
            
            return [self createLastCell:tableView indexPath:indexPath];
            
        }else{
            
            return [self createLastSecondCell:tableView indexPath:indexPath];
            
        }
        
    }
    if (indexPath.section == 7) {
        
    return [self createLastCell:tableView indexPath:indexPath];
  
    }

    //详细部分
   return [self createDetailCell:tableView indexPath:indexPath];
}

-(UITableViewCell *)createLastSecondCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 4 ) {
        cell = [ExpenseCell createCellWith:_detailBootomCellFrame];
    }
    if (indexPath.section == 5 ) {
        cell = [TimeCell createCellWith:_detailBootomCellFrame];
    }
    if (indexPath.section == 6) {
        __weak TLDetailViewController *weakself = self;
        cell = (OrderCell *)[OrderCell createCellWithTableView:tableView model:_selectM go:^{
            
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = _selectM.order_url;
            
            [weakself.navigationController pushViewController:web animated:YES];
            
        }];
        
    }
    return cell;
}
//底部固定的cell
-(UITableViewCell *)createLastCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    __weak TLDetailViewController *weakself = self;
    LastCell *cell = nil;
    if (indexPath.section == 4) {
        NSString *price = _selectM.price;
        
        cell =[LastCell createCell:@"费用" accessaryType:YES rightTitle:price action:^{
            [weakself accessoryActionWithKey:kExpense row:1 section:4];

        }];
        //如果没有花费详情
        if (_selectM.expense.count == 0) {
            cell.accessoryView = nil;
        }

        
    }
    if (indexPath.section == 5) {
        
        cell =[LastCell createCell:@"时间" accessaryType:YES rightTitle:nil action:^{
            
            [weakself accessoryActionWithKey:kTime row:1 section:5];
           
        }];
        
    }
    if (indexPath.section == 6) {
        
       cell =[LastCell createCell:@"预定方式" accessaryType:YES rightTitle:nil  action:^{
           
           [weakself accessoryActionWithKey:kOrder row:1 section:6];
            NSLog(@"预定方式");
        }];
        
    }
    if (indexPath.section == 7) {
        cell =[LastCell createCell:@"评论" accessaryType:NO rightTitle:nil  action:^{
            NSLog(@"评论");
        }];

    }
    
       return cell;


}
//顶部固定cell
-(UITableViewCell *)createTopCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    __weak TLDetailViewController *weakSelf = self;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor];
        TLTitleView *view = [[TLTitleView alloc] initWithFrame:CGRectMake(2*kMargin, kScreenHeight *3/8 - 40, kScreenWidth - 2*kMargin, 40)];
        [cell.contentView addSubview:view];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [view addTitle:_selectM.title subTitle:_selectM.sub_title topBootomScale:0.4 titleFont:18 subTitleFont:13];
    }
    if (indexPath.section == 1) {
        
        LikeCell *cell = [LikeCell createLikeCellWithLikeUser:_selectM.like_user];
        cell.moreBlock = ^{
            
            LikeUserLIstTVC *listVC = [[LikeUserLIstTVC alloc] init];
            listVC.ID = weakSelf.selectM.ID;
            [weakSelf.navigationController pushViewController:listVC animated:YES ];
        };
        return cell;
        
    }
    if (indexPath.section == 2) {
        LocationCell *cell = [LocationCell createCellWithModel:_selectM mapBlock:^{
            
            MapViewVC *vc = [[MapViewVC alloc]init];
            vc.locationModel = weakSelf.selectM.location;
            vc.locationName = weakSelf.selectM.address;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            NSLog(@"打开地图");
            
        }];
        return cell;
    }
    return cell;
}
-(UITableViewCell *)createDetailCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{

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
    //如果是达人推荐添加达人推荐
    if ([type isEqualToString:@"referrer"]) {
        ReferrerCell *cell = [ReferrerCell createCellWith:tableView];
        cell.referrer = _selectM.referrer;
        return cell;
    }
    
    // 图片
    ImageCell *cell = [ImageCell createCellWith:tableView];
    cell.imageUrls = _imageUrls;
    cell.frameM = frame;
    
    return cell;
    

}
#pragma mark scrollVIew 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < - 3 * kScrollMargin) {
        scrollView.contentOffset = CGPointMake(0, - 3 * kScrollMargin);
    }else{
        if (offSetY > 0) {
            _topIV.transform = CGAffineTransformMakeTranslation(0, -offSetY);
            
        }else{
        
            _topIV.transform = CGAffineTransformMakeTranslation(0, -offSetY/3);
        }
    }
    
    CGFloat standardOffsetY = kScreenHeight * 3/8 - kScrollMargin - CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    
        
   
    if (offSetY > standardOffsetY) {
       
        self.navigationController.navigationBar.hidden = NO;
    }else {
        self.navigationController.navigationBar.hidden = YES;
    }
        

}
#pragma  mark 获取数据
- (void)setSelectM:(SelectModel *)selectM
{
    _imageUrls = [NSMutableArray array];
    
    _selectM = selectM;
    NSArray *array = _selectM.details;
    _frames = [[NSMutableArray alloc]initWithCapacity:array.count];
    
    int i = 0;
    //遍历数据
    for (DetailModel *model in array) {
        if ([model.type isEqualToString:@"head"] ) {
            i ++;
        }
        if (i < 3 && i != 2) {
            _firstLoadCount ++;
        }
        
        DetailCellFrame *frame = [[DetailCellFrame alloc]init];
        frame.detailM = model;
        
        [_frames addObject:frame];
        
        if ([model.type isEqualToString:@"pic"]) {
            
            [_imageUrls addObject:model.content.url];
        }
    }
    
    _firstLoadCount = _firstLoadCount + 2;
    
    _loadCount =  _firstLoadCount;
    //是否小于 避免崩溃
    if (_loadCount <= _frames.count) {
        
        if (_loadCount == _frames.count) {
             _isHiddenLoadMore = YES;
        }
        
    }else{
        
        if (_loadCount - 1 <= _frames.count) {
            _loadCount = _loadCount - 1;
        }else {
        _loadCount = _loadCount - 2;
        }
        _isHiddenLoadMore = YES; //隐藏加载更多按钮
    }
    _detailBootomCellFrame = [[DetailBootomCellFrame alloc]init];
    
    //为底部 伤心的四个 设置模型
    _detailBootomCellFrame.selectM = _selectM;
    
}
#pragma  - mark 获取详情底部数据
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    NSLog(@"tldetail收到内存警告");
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
