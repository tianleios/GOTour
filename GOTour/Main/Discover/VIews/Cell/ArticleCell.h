//
//  ArticleCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PageBlock)(UIPageControl *);
@class TLScrollVIew;

@interface ArticleCell : UICollectionViewCell<UIScrollViewDelegate>

@property (nonatomic,strong) TLScrollVIew *scrollView;

@property (nonatomic,strong) NSArray *articles;

@property (nonatomic,assign) NSInteger numPage;

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,copy)  PageBlock block;

+(instancetype)createCelllWithReusableID:(NSString *)ID articles:(NSArray *)articles collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
