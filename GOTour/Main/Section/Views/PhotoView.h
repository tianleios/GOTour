//
//  PhotoView.h
//  GOTour
//
//  Created by 磊 田 on 15/10/20.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIImageView <UIAlertViewDelegate>

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) NSArray *imageUrls;


@end
