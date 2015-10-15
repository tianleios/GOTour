//
//  ThemeViewController.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "TopViewController.h"
#import "CollectionModel.h"
@interface ThemeViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *collections;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
