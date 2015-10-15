//
//  SelectFrame.h
//  tianleilnl
//
//  Created by 磊 田 on 15/10/11.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectModel.h"
#import "MainCollectionModel.h"
@interface SelectFrame : NSObject

//有两种模型
@property (nonatomic, strong) SelectModel *selectM;

@property (nonatomic, strong) MainCollectionModel *mainCM;
//
@property (nonatomic, assign) CGRect scrrollFrame;

@property (nonatomic, assign) CGRect topButFrame;

@property (nonatomic, assign) CGRect shortDescFrame;

@property (nonatomic, assign) CGRect imageFrame;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect subtitleFrame;

@property (nonatomic, assign) CGRect wwFrame;

@property (nonatomic, assign) CGFloat rowHeight;



@end
