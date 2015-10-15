//
//  MyAnnotation.h
//  GOTour
//
//  Created by 磊 田 on 15/10/12.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic,  copy, nullable) NSString *title;
@property (nonatomic,  copy, nullable) NSString *subtitle;
@end
