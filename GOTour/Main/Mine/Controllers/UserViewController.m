//
//  UserViewController.m
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "UserViewController.h"
#import "SetTableViewController.h"
#import "SelectModel.h"
#import "ThemeNextCell.h"
#import "TLDetailViewController.h"
#import "FMDatabase.h"
#define topImageHeight kScreenHeight*2.7/8
@interface UserViewController ()

@property (nonatomic, strong) UIImageView *background;

@property (nonatomic, strong) UIImageView *icon;


@property (nonatomic, strong) UILabel *introLbl;

@property (nonatomic, weak) UITableView *tableView;

//姓名 和 点击登录 lbl
@property (nonatomic, weak) UILabel *specialLbl;



@property (nonatomic, strong) UIButton *settingBut;

//收藏 和推荐的数据
@property (nonatomic, strong) NSMutableArray *likes;

@end

@implementation UserViewController

- (void)dealloc
{
    NSLog(@"zuihou的控制器 被销毁");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  self.navigationController.navigationBar.hidden = YES;
    _likes = [TLHTTPTool getDataFromDB];
    [_tableView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    NSLog(@"%@",NSHomeDirectory());
    [self setUserView];
    
    [self addTopImage];
    
    [self createTableView];
    //设置按钮
    [self addSetingBut];
    
    
}

/**
 * 添加顶部大图片
 */
- (void)addTopImage
{
    
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, topImageHeight)];
    _background.image = [UIImage imageNamed:@"collect_bg.jpg"];
    
    if (_referrer.bg_pic.length != 0) {
        
        NSURL *url = [NSURL URLWithString:_referrer.bg_pic];
        [_background sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    }
    
    [self.view addSubview:_background];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight/8, kScreenWidth, 50)];
    [self.view insertSubview:lbl aboveSubview:_background];
    lbl.text = @"点击登录";
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    _specialLbl = lbl;
}
- (void) addSetingBut
{
    _settingBut = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 20, 40, 40)];
    
    [_settingBut addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    [_settingBut setImage:[UIImage imageNamed:@"034@2x.png"] forState:UIControlStateNormal];
    
    [self.view insertSubview:_settingBut aboveSubview:_tableView];
}
- (void)setUserView
{
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, -60, 80, 80)];
    _icon.layer.cornerRadius = 40;
    _icon.layer.masksToBounds = YES;
    _icon.image = [UIImage imageNamed:@"defaultavatar.png"];
    _icon.backgroundColor = [UIColor blueColor];

    CGFloat iconY = CGRectGetMaxY(_icon.frame);
    _introLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, iconY + kMargin, kScreenWidth, 30)];

    _introLbl.text = @"田磊";
    
    _introLbl.font = [UIFont systemFontOfSize:12];
    _introLbl.numberOfLines = 0;
    _introLbl.textAlignment =NSTextAlignmentCenter;
    
}

- (void)createTableView
{
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.navigationController.navigationBar.frame.size.height - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:tb];
    
    _tableView = tb;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

#pragma 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
   return _likes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    
    
    if (indexPath.section == 0) {
        UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        return cell;
    
    }
    ThemeNextCell *cell = [ThemeNextCell createCellWithTableView:tableView];
    
    NSDictionary *dict = _likes[indexPath.row];
    
    cell.imageCache = dict[@"image"];
    cell.selectM = dict[@"selectM"];
    
    return cell;
    
    

}

#pragma - mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        TLDetailViewController *vc = [[TLDetailViewController alloc] init];
        NSDictionary *dict = _likes[indexPath.row];
        vc.selectM = dict[@"selectM"];
        vc.isLike = YES;
        vc.dataID = @([dict[@"identify"] integerValue]);
       
        [self.navigationController pushViewController:vc animated:YES];
    }


}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        
        [view1 addSubview:_icon];
        [view1 addSubview:_introLbl];
        
        return view1;
       
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 55;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kScreenHeight*2.7/8;
    }
    return kScreenWidth/1.6 + 4;
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

- (void)setAction
{
    
    SetTableViewController *vc = [[SetTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
