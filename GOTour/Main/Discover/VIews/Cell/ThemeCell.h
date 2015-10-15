//
//  ThemeCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
@interface ThemeCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, strong) NSString *urlString;


+(instancetype)createCelllWithReusableID:(NSString *)ID collections:(NSArray *)collections collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) CollectionModel *collectionModel;

@end
