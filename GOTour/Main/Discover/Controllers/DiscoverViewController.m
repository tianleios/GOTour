//
//  DiscoverViewController.m
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "DiscoverViewController.h"

#import "SearchViewController.h"
#import "ThemeViewController.h"
#import "NextDetailViewController.h"
#import "ThemeNextTVC.h"

#import "SelectModel.h"
#import "ArticleModel.h"

#import "ArticleCell.h"
#import "TagCell.h"
#import "NextCell.h"
#import "ThemeCell.h"
#import "TopSellectionCell.h"

#import "MBProgressHUD.h"

#import "TLDetailViewController.h"
#import "DiscoverModel.h"
#import "TLScrollVIew.h"

#import "TitleLbl.h"

#define kMinSpace kScreenWidth/32

#define kDiscoverBaseUrl @"http://appsrv.flyxer.com/api/digest/discovery?did=18652"
#define kTopOneWeakUrl @"http://appsrv.flyxer.com/api/digest/recomm/"

#define kArticleCellID @"articleCell"
#define kTagCellID @"tagCell"
#define kNextCellID @"nextCell"
#define kThemeCellID @"themeCell"
#define kTopSectionCellID @"topCell"

#import "MJExtension.h"

@interface DiscoverViewController ()

@property (nonatomic,strong) DiscoverModel *discovers;
@property (nonatomic,strong) MBProgressHUD *progressHUD;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation DiscoverViewController
- (void)dealloc
{
    NSLog(@"第2控制器 被销毁");
}
- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发现";
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    //导航栏左侧按钮
    [self navigationRightItem];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    //请求数据 数据成功后在 创建相应视图
    [self loadData];
    //创建视图
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    CGFloat h = CGRectGetMaxY(self.navigationController.navigationBar.frame);
   
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
       _collectionView.frame = frame;
}
- (void)navigationRightItem
{
//    home_search2.png
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [but setImage:[UIImage imageNamed:@"home_search2.png"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem  = leftItem;

}

- (void)searchAction
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];

}
-(void)loadData
{
    
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //开始请求
    [TLHTTPTool requestDataWithUrl:kDiscoverBaseUrl parameters:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        
        _discovers = [DiscoverModel objectWithKeyValues:dict];
       
    // 成功后 关闭_progressHUD
        [_progressHUD hide:YES];
        
#pragma - mark 创建collectionView
        
        [self createCollectionView];
    }fail:^(id error) {
        NSLog(@"discover数据请求失败");
    }];

}
- (void)createCollectionView
{
    //布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout = layout;
    //collectionView
    CGFloat h = CGRectGetMaxY(self.navigationController.navigationBar.frame);
   
    CGRect frame = CGRectMake(0, h, kScreenWidth, kScreenHeight - h - 49);
  
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [_collectionView registerClass:[ArticleCell class] forCellWithReuseIdentifier:kArticleCellID];
    
    [_collectionView registerClass:[TagCell class] forCellWithReuseIdentifier:kTagCellID];
    
    [_collectionView registerClass:[NextCell class] forCellWithReuseIdentifier:kNextCellID];
    
    [_collectionView registerClass:[ThemeCell class] forCellWithReuseIdentifier:kThemeCellID];
    
    [_collectionView registerClass:[TopSellectionCell class] forCellWithReuseIdentifier:kTopSectionCellID];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

//    //注册头跟尾
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"one"];
    //注册头跟尾
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"two"];
    //注册头跟尾
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"stree"];
    //注册头跟尾
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"four"];

}
#pragma mark flowLayout 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        [self goToThemeDetail:indexPath collectionView:collectionView];
    }
    if (indexPath.section == 4) {
//          [MBProgressHUD showHUDAddedTo:_collectionView animated:YES];
        [self goToOneWeakHot:indexPath collectionView:collectionView];
    }
    if (indexPath.section == 2) {
        [self goTONextStepDetail:indexPath collectionView:collectionView];
    }
    if (indexPath.section == 1) {
        [self goToTagDetail:indexPath collectionView:collectionView];
    }

}

- (void)goToTagDetail:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    TagCell *cell = (TagCell *)[collectionView cellForItemAtIndexPath:indexPath];

    ThemeNextTVC *vc = [[ThemeNextTVC alloc]init];
    vc.ID = cell.tagModel.ID;
    vc.name = cell.tagModel.name;
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)goTONextStepDetail:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    NextCell *cell = (NextCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NextDetailViewController *vc = [[NextDetailViewController alloc]init];

    vc.ID = cell.nextModel.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goToOneWeakHot:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    TopSellectionCell *cell = (TopSellectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
   MBProgressHUD * _hud = [MBProgressHUD showHUDAddedTo:cell animated:YES];
    _hud.color = [UIColor colorWithWhite:0 alpha:0.8];
    _hud.xOffset = -kScreenWidth/4;
//    TopSellectionCell *cell = (TopSellectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *ID =  [cell.topModel.selection.ID stringValue];
    
    NSString *urlStr = [kTopOneWeakUrl stringByAppendingString:ID];
    
    NSDictionary *dict = @{
                           @"v":@"2"
                           };
    [TLHTTPTool requestDataWithUrl:urlStr parameters:dict success:^(id responseObject) {
        
        TLDetailViewController *dvc = [[TLDetailViewController alloc] init];
        dvc.selectM = [SelectModel objectWithKeyValues:responseObject];
        [self.navigationController pushViewController:dvc animated:YES];
        [_progressHUD hide:YES];
        [_hud hide:YES];
    } fail:^(id error) {
        
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"失败";
        [_hud hide:YES afterDelay:1.5];
//        [_hud hide:YES];
        

    }];


}
- (void)goToThemeDetail:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
   ThemeCell *cell = (ThemeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.urlString.length != 0 ) {
        WebViewController *wvc = [[WebViewController alloc]init];
        wvc.urlString = cell.urlString;
        [self.navigationController pushViewController:wvc animated:YES];
    }else{
        TopViewController *topVC = [[TopViewController alloc]init];
        topVC.collectionM = cell.collectionModel;
        topVC.urlStr = cell.collectionModel.bg_pic[0];
        [self.navigationController pushViewController:topVC animated:YES];
    
    }
    

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 180);
    }
    if (indexPath.section == 1) {
         CGFloat w = (kScreenWidth- 6*kMinSpace)/5;
        return CGSizeMake((kScreenWidth- 6*kMinSpace)/5, w*1.37);
    }
    if (indexPath.section == 2) {
         CGFloat w = (kScreenWidth - 3*kMinSpace)/2;
        return CGSizeMake(w, w/1.65);
    }
    if (indexPath.section == 3) {
        CGFloat w = kScreenWidth - 2*kMinSpace;
        return CGSizeMake(w, w/2.3);
    }
       CGFloat w = kScreenWidth - 2*kMinSpace;
       return CGSizeMake(w, w/3.3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, 10, 10, 10);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;
}
//// 页眉
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth - 20, 40);
}
//// 页脚
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeZero;
//}
#pragma mark 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 4;
    }
    if (section == 3) {
        return 3;
    }
    return 5;

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 5;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TitleLbl *lbl = nil;
        if (indexPath.section == 1) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"one" forIndexPath:indexPath];
            lbl = [TitleLbl createLblWithFrame:CGRectMake(2*kMargin, 0, kScreenWidth/2, reusableView.frame.size.height) title:@"我的兴趣🐷"];
            
        }
        if (indexPath.section == 2) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"two" forIndexPath:indexPath];
            lbl = [TitleLbl createLblWithFrame:CGRectMake(2*kMargin, 0, kScreenWidth/2, reusableView.frame.size.height) title:@"下一站🚂"];
            
        }
        if (indexPath.section == 3) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"stree" forIndexPath:indexPath];
           lbl = [TitleLbl createLblWithFrame:CGRectMake(2*kMargin, 0, kScreenWidth/2, reusableView.frame.size.height) title:@"精选主题🌲"];
            UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 40, 14, 40, 20)];
            but.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
            [but setImage:[UIImage imageNamed:@"activity_RightAccessory"] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(themeButAction) forControlEvents:UIControlEventTouchUpInside];
            [reusableView addSubview:but];
        }
        if (indexPath.section == 4) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"four" forIndexPath:indexPath];
            lbl = [TitleLbl createLblWithFrame:CGRectMake(2*kMargin, 0, kScreenWidth/2, reusableView.frame.size.height) title:@"一周最热☀️"];
            
        }

        [reusableView addSubview:lbl];
        return reusableView;
    }

    return nil;

}
#pragma mark - 主题 按钮
- (void)themeButAction
{
    ThemeViewController *vc = [[ThemeViewController alloc] init];
    vc.collections = _discovers.collections;
    [self.navigationController pushViewController:vc animated:YES];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

     ArticleCell *cell = [ArticleCell createCelllWithReusableID:kArticleCellID articles:_discovers.articles collectionView:collectionView indexPath:indexPath];
#pragma - mark 为顶部图片浏览器添加手势
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [cell addGestureRecognizer:tap];
        return cell;
        
        }
    if (indexPath.section == 1) {
        return [TagCell createCelllWithReusableID:kTagCellID tags:_discovers.tags collectionView:collectionView indexPath:indexPath];
    }
    if (indexPath.section == 2) {
        
        return [NextCell createCelllWithReusableID:kNextCellID tags:_discovers.next_stops collectionView:collectionView indexPath:indexPath];
    }
    if (indexPath.section == 3) {
        return [ThemeCell createCelllWithReusableID:kThemeCellID collections:_discovers.collections collectionView:collectionView indexPath:indexPath];
    }
    if (indexPath.section == 4) {
        return [TopSellectionCell createCelllWithReusableID:kTopSectionCellID topSellections:_discovers.top_selections collectionView:collectionView indexPath:indexPath];
    }
    
    return nil;
}

- (void)tapAction
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
  ArticleCell *cell = (ArticleCell *)[_collectionView cellForItemAtIndexPath:path];
   
    ArticleModel *model = cell.articles[cell.pageControl.currentPage];
        
    NextDetailViewController *nvc = [[NextDetailViewController alloc] init];
        
    nvc.ID = model.ID;
   
    [self.navigationController pushViewController:nvc animated:YES];
   
}
#pragma mark 代理方法
//- (void)
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0);

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ArticleCell *cell = (ArticleCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.scrollView.timer invalidate];
   
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
