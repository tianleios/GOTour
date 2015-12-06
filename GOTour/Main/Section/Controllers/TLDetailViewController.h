//
//  TLDetailViewController.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.

//多方调试不成功 废弃

#import <UIKit/UIKit.h>
#import "UMSocial.h"

@class SelectModel;
@interface TLDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) SelectModel *selectM;
@property (nonatomic, strong) UIImage *imageCache;

@property (nonatomic, assign) BOOL isLike;

@property (nonatomic, strong) NSNumber *dataID;





@end
