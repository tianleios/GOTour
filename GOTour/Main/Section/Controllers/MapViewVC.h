//
//  MapViewVC.h
//  旅行
//
//  Created by 磊 田 on 15/10/10.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "LocationModel.h"
@interface MapViewVC : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) LocationModel *locationModel;
@property (nonatomic, copy) NSString *locationName;
@end
