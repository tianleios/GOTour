//
//  DestinationViewController.m
//  旅行
//
//  Created by 磊 田 on 15/9/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "DestinationViewController.h"

#import "ListViewController.h"
#import "TLDetailViewController.h"

#import "MBProgressHUD.h"
#import "TLTitleView.h"

#import "FirstDestionModel.h"
#import "FirstCollectionCell.h"
#import "NUllCell.h"

#define kResuableImageID @"imageCell"
#define kResuableTitleID @"titleCell"

#define kMinSpace kScreenWidth/32

#define kDestionUrl @"http://appsrv.flyxer.com/api/digest/recomm/dests?page=1"
@interface DestinationViewController ()

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *destions;

@property (nonatomic, weak) UIAlertView *alertV;

@end

@implementation DestinationViewController

-(void)dealloc
{
    NSLog(@"dealloc destination被销毁");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目的地";
//    self.navigationController.navigationBar.hidden = NO;

//    self.navigationController.delegate = self;
    [self addLeftItem];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    //请求数据
    [self requestData];
}
- (void)addLeftItem
{
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [but setImage:[UIImage imageNamed:@"home_search2.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = rightItem;


}
- (void)requestData
{
   MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TLHTTPTool requestDataWithUrl:kDestionUrl parameters:nil success:^(id responseObject) {
        NSArray *array = responseObject;
        _destions = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSDictionary *dict in responseObject) {
            
          FirstDestionModel *model = [FirstDestionModel objectWithKeyValues:dict];
            [_destions addObject:model];
            
        }
        [progressHUD hide:YES];
        [self createCollectionView];
    } fail:^(id error) {
        [progressHUD hide:YES];
        [self createAlertView];
    }];

}
- (void)createAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"是否重新加载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [self.view addSubview:alertView];
    _alertV = alertView;
    [alertView show];
    
}
- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout = flowLayout;
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat Y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGRect frame = CGRectMake(0, Y, kScreenWidth, kScreenHeight - 49 - Y);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:_flowLayout];
    [self.view addSubview:collectionView];
    
    _collectionView = collectionView;
    
    _collectionView.backgroundColor = [UIColor whiteColor];

    //注册
    [_collectionView registerClass:[FirstCollectionCell class] forCellWithReuseIdentifier:kResuableImageID];
    
    [_collectionView registerClass:[NUllCell class] forCellWithReuseIdentifier:kResuableTitleID];
    
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}
#pragma - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCollectionCell *cell = (FirstCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ListViewController *lvc = [[ListViewController alloc] init];
    
    lvc.firstM = cell.firstDM;
    [self.navigationController pushViewController:lvc animated:YES];
}
#pragma - mark 代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(kScreenWidth - 5*kMargin, 20);
    }
    
        CGFloat w = (kScreenWidth - 3*kMinSpace)/2;
        return CGSizeMake(w,w);
 
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 10, 10);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;
}

#pragma - mark 数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return _destions.count;
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NUllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kResuableTitleID forIndexPath:indexPath];
        return cell;
        
    }
          FirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kResuableImageID forIndexPath:indexPath];
        FirstDestionModel *model = _destions[indexPath.row];
       
        cell.firstDM = model;
        return cell;
   
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self performSelector:@selector(requestData)];
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
