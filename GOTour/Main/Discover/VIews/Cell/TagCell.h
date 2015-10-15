//
//  TagCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"
@interface TagCell : UICollectionViewCell


@property (nonatomic, strong) TagModel *tagModel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLbl;

+(instancetype)createCelllWithReusableID:(NSString *)ID tags:(NSArray *)tags collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
