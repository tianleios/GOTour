//
//  TopSellectionCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopSelectionModel.h"
@interface TopSellectionCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, strong) UILabel *subTextLbl;


+(instancetype)createCelllWithReusableID:(NSString *)ID topSellections:(NSArray *)topSellections collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) TopSelectionModel *topModel;


@end
