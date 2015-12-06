//
//  MineViewController.m
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "MineViewController.h"
#import "MainTabBarController.h"
#import "TLNavigationController.h"
#import "MBProgressHUD.h"
#import "ThemeNextCell.h"
#import "TLDetailViewController.h"

#import "SetTableViewController.h"
#import "AFNetworking.h"
#import "ListCell.h"
#import "LikePrdBut.h"

#define topImageHeight kScreenHeight*2.7/8
#define kUserPrdUrl  @"http://appsrv.flyxer.com/api/usr/"
#define kUserLikeUrl @"http://appsrv.flyxer.com/api/usr/"
@interface MineViewController ()

@property (nonatomic, strong) UIImageView *background;

@property (nonatomic, strong) UIImageView *icon;


@property (nonatomic, strong) UILabel *introLbl;

@property (nonatomic, weak) UITableView *tableView;

//姓名 和 点击登录 lbl
@property (nonatomic, weak) UILabel *specialLbl;


@property (nonatomic, assign) NSInteger loadCount;

@property (nonatomic, strong) UIButton *backBut;

@property (nonatomic, strong) UIButton *settingBut;

//收藏 和推荐的数据
@property (nonatomic, strong) NSMutableArray *prds;
@property (nonatomic, strong) NSMutableArray *likes;


//收藏和推荐按钮
@property (nonatomic, strong) LikePrdBut *likeBut;
@property (nonatomic, strong) LikePrdBut *prdBut;
@property (nonatomic, strong) UIImageView *imageBut;

//是收藏 还是 推荐
@property (nonatomic, assign) BOOL isLike;

@end

@implementation MineViewController
- (void)dealloc
{
    NSLog(@"销毁");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    
    _loadCount = 2;
 //是否加返回按钮
    
 //顶部
    [self addTopImage];
 //中间
    [self setUserView];
    
    //创建
    [self createTableView];
    
    //尾部
    if (!([_referrer.prd_num  isEqual: @0])) {
       
        [self requestPrdData];
    }
    
    

   
    [self addbackBut];
    
    
}
#pragma mark -
- (void)requestLikeData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = 100;
    hud.dimBackground = YES;
    NSString *urlStr = [kUserPrdUrl stringByAppendingString:[NSString stringWithFormat:@"%@/likes",_referrer.userID]];
    NSDictionary *parameterDict = @{
                                    @"page":@"1",
                                    @"v":@"2",
                                    @"size":@"20"
                                    };
    //创建
    _likes = [NSMutableArray array];
    //申请数据
    [TLHTTPTool requestDataWithUrl:urlStr parameters:parameterDict success:^(id responseObject) {

        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"results"];
      
        for (NSDictionary *sDict in array) {
            SelectModel *model = [SelectModel objectWithKeyValues:sDict];
            [_likes addObject:model];
        }
      
  [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:YES];
        [hud hide:YES];
        
            } fail:^(id error) {
        NSLog(@"失败");
        [hud hide:YES];
    }];


}

- (void)requestPrdData
{
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = 100;
    hud.dimBackground = YES;
    _prds = [NSMutableArray array];
    NSString *urlStr = [kUserPrdUrl stringByAppendingString:[NSString stringWithFormat:@"%@/products",_referrer.userID]];
    NSDictionary *parameterDict = @{
                                    @"page":@"1",
                                    @"v":@"2",
                                    @"size":@"20"
                                    };
    [TLHTTPTool requestDataWithUrl:urlStr parameters:parameterDict success:^(id responseObject) {
         NSDictionary *dict = responseObject;
         NSArray *array = dict[@"results"];
        for (NSDictionary *sDict in array) {
            SelectModel *model = [SelectModel objectWithKeyValues:sDict];
            [_prds addObject:model];
            
            
           
        }
        
         [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:YES];
        [hud hide:YES];
    } fail:^(id error) {
        NSLog(@"失败");
        [hud hide:YES];
    }];

}
- (void)addTopImage
{

    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, topImageHeight)];
    _background.image = [UIImage imageNamed:@"collect_bg.jpg"];
    
    if (_referrer.bg_pic.length != 0) {
        
        NSURL *url = [NSURL URLWithString:_referrer.bg_pic];
        [_background sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    }
    
    [self.view addSubview:_background];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight*0.95/8, kScreenWidth, 50)];
    [self.view insertSubview:lbl aboveSubview:_background];
    lbl.text = @"点击登录";
    
    lbl.text = _referrer.username;
    
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    
    _specialLbl = lbl;
    
}

- (void)setUserView
{
  
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, -60, 80, 80)];
    _icon.layer.cornerRadius = 40;
    _icon.layer.masksToBounds = YES;
    _icon.image = [UIImage imageNamed:@"defaultavatar.png"];
    _icon.backgroundColor = [UIColor blueColor];
    //有头像加载头像
    if (_referrer.photo_url != nil) {
        NSURL *url = [NSURL URLWithString:_referrer.photo_url];
        [_icon sd_setImageWithURL:url];
    }
    //用户介绍
    CGFloat iconY = CGRectGetMaxY(_icon.frame);
    _introLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, iconY + kMargin, kScreenWidth, 30)];
    _introLbl.backgroundColor = [UIColor whiteColor];
    if (_referrer.intro != nil) {
        _introLbl.text = _referrer.intro;
    }else{
        _introLbl.text = @"这这家伙很懒，还没写自我介绍";
    }
    _introLbl.font = [UIFont systemFontOfSize:12];
    _introLbl.numberOfLines = 0;

    _introLbl.textAlignment =NSTextAlignmentCenter;
    
//
}


- (void)createTableView
{
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:tb];
    
    _tableView = tb;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

}
#pragma  -mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = _isLike?_likes:_prds;
    if (indexPath.section == 1) {
        TLDetailViewController *tlvc = [[TLDetailViewController alloc] init];
        
        tlvc.selectM = array[indexPath.row];
        [self.navigationController pushViewController:tlvc animated:YES];
        
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 100;
    }
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1;
    }
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kScreenHeight*2.7/8;
    }
    return kScreenWidth/1.6 + 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
       if (section == 0) {
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        [view1 addSubview:_icon];
          
        [view1 addSubview:_introLbl];
        [self likePrdBut:view1];

        
        return view1;
    }
   
    return nil;
    
}
- (void)likePrdBut:(UIView *)view
{
    _imageBut = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth/2, 45)];
    _imageBut.image = [UIImage imageNamed:@"activity_Tit.png"];
    [view addSubview:_imageBut];
       //
    _likeBut = [[LikePrdBut alloc] initWithFrame:CGRectMake(kScreenWidth/2, 55, kScreenWidth/2, 45)];
//    _likeBut.backgroundColor = [UIColor cyanColor];
    NSString *str0 = [NSString stringWithFormat:@"收藏%@",[_referrer.like_num stringValue]];
    [_likeBut setTitle:str0 forState:UIControlStateNormal];
    
    [_likeBut addTarget:self action:@selector(colectionAction) forControlEvents:UIControlEventTouchUpInside];
    //
    _prdBut = [[LikePrdBut alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth/2, 45)];
//    _prdBut.backgroundColor = [UIColor redColor];

    NSString *str = [_referrer.prd_num stringValue];
    NSString *str1 = [NSString stringWithFormat:@"推荐%@",str];
    
    [_prdBut setTitle:str1 forState:UIControlStateNormal];
    [_prdBut addTarget:self action:@selector(recommendAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_prdBut];
    [view addSubview:_likeBut];
}
#pragma  -mark 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isUser == NO) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {

        return 1;
       
    }
    if (_isLike == YES) {
        return _likes.count;
    }
    
    return _prds.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
      UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
       NSArray *array = _isLike?_likes:_prds;
    if (_isLike == NO) {
    }
    
        ThemeNextCell *cell = [ThemeNextCell createCellWithTableView:tableView];
        cell.selectM = array[indexPath.row];
       return cell;

    
}

#pragma scrollView 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
     CGRect frame = CGRectMake(0, 0, kScreenWidth, topImageHeight);

   
    if (offSetY > 0) {
         _background.transform = CGAffineTransformMakeTranslation(0, -offSetY);
        _specialLbl.transform = CGAffineTransformMakeTranslation(0, -offSetY);
    }else{
        //计算放大倍数
        CGFloat scale = 1 - offSetY/(topImageHeight);
        
        CGFloat shouldX = - kScreenWidth*(scale - 1)/2;
        
        frame.origin = CGPointMake(shouldX, 0);
        
        _background.transform = CGAffineTransformMakeScale(scale, scale);
        _background.frame = CGRectMake(shouldX,0, scale*kScreenWidth, topImageHeight - offSetY);
        _specialLbl.transform = CGAffineTransformMakeTranslation(0, -offSetY/4);
    }
    


}
- (void) addbackBut
{
    _backBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [_backBut setImage:[UIImage imageNamed:@"button_back@2x.png"] forState:UIControlStateNormal];
    [_backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_backBut aboveSubview:_tableView];
    
}


- (void)backAction
{
//   UIWindow *win = [UIApplication sharedApplication].windows[0];
//    MainTabBarController *mvc = (MainTabBarController *)win.rootViewController;
//    TLNavigationController *tlnvc = mvc.viewControllers[0];
//    [tlnvc popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)colectionAction
{
    _imageBut.center = _likeBut.center;
    _likeBut.enabled =  NO;
    
    _prdBut.enabled = YES;
    _isLike = YES;
    if (_likes == nil ) {
        [self requestLikeData];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
   
    
}
- (void)recommendAction
{
    _imageBut.center = _prdBut.center;

    _likeBut.enabled =  YES;
    _prdBut.enabled = NO;

    _isLike = NO;
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

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
