//
//  ThemeViewController.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ThemeViewController.h"

#import "ThemeCell.h"

#define kTopBaseUrl @"http://appsrv.flyxer.com/api/digest/collection"
@interface ThemeViewController ()

@end
#define kMinSpace 10
static NSString * const reuseIdentifier = @"Cell";

@implementation ThemeViewController
-(void)dealloc
{
    NSLog(@"themeviewl销毁");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专辑";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
//    CGFloat h = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ThemeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    // Dispose of any resources that can be recreated.
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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
    CGFloat w = kScreenWidth - 2*kMinSpace;
    return CGSizeMake(w, w/2.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinSpace;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ThemeCell *cell =  [ThemeCell createCelllWithReusableID:reuseIdentifier
                                                collections:_collections collectionView:collectionView indexPath:indexPath];
    
    return cell;
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
