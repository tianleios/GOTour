//
//  LocationCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

typedef void(^MapBlock)(void);
+(instancetype)createCellWithAdress:(NSString *)adress mapBlock:(MapBlock)block;

@property (nonatomic, copy) MapBlock block;
@end
